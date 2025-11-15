import { APP_INITIALIZER, ModuleWithProviders, NgModule, Optional, SkipSelf } from "@angular/core";
import { AuthService } from "./auth/auth.service";
import { environment } from "../../environments/environments";
import { createInterceptorCondition, INCLUDE_BEARER_TOKEN_INTERCEPTOR_CONFIG, IncludeBearerTokenCondition, includeBearerTokenInterceptor, KeycloakAngularModule, KeycloakBearerInterceptor, KeycloakService } from "keycloak-angular";
import { HTTP_INTERCEPTORS, HttpClient, HttpClientModule, provideHttpClient, withInterceptors } from "@angular/common/http";
import { AuthGuard } from "./auth/auth.guard";
import { HttpErrorInterceptor } from "./middleware/http-error.interceptor";
import { initializeKeycloak } from "./auth/keycloak/keycloak.init";

// Singleton



export const urlCondition = createInterceptorCondition<IncludeBearerTokenCondition>({
  urlPattern: new RegExp(`^(${environment.apiUrl})(/.*)?$`, 'i'),
  bearerPrefix: 'Bearer'
});
@NgModule({
  imports: [
    // KeycloakAngularModule
  ],
})
export class CoreModule {
  constructor(@Optional() @SkipSelf() parentModule: CoreModule) {
    if (parentModule) {
      throw new Error('CoreModule is already loaded. Import it in the AppModule only.');
    }
  }

  // static forRoot(config?: { apiBase: string }): ModuleWithProviders<CoreModule> {
  static forRoot(): ModuleWithProviders<CoreModule> {
    return {
      ngModule: CoreModule,
      providers: [
        {
          provide: APP_INITIALIZER,
          useFactory: initializeKeycloak,
          multi: true,
          deps: [KeycloakService],
        },
        AuthService,
        KeycloakService, // Mark as provider in this module or auth module if separete
        AuthGuard,
        { provide: HTTP_INTERCEPTORS, useClass: HttpErrorInterceptor, multi: true },
        // {
        //   provide: INCLUDE_BEARER_TOKEN_INTERCEPTOR_CONFIG,
        //   useValue: [urlCondition]
        // },

        {
          provide: HTTP_INTERCEPTORS,
          useClass: KeycloakBearerInterceptor,
          multi: true
        },



      ]
    };
  }
}
