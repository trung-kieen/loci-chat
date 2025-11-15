import {
  NgModule,
  provideBrowserGlobalErrorListeners,
  provideZoneChangeDetection,
} from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AccessDenied } from './core/components/access-denied/access-denied';
import { UserInfo } from './core/components/user-info/user-info';

import {  routes } from './app.routes';
import { App } from './app';
import {  RouterModule } from '@angular/router';
import { SharedModule } from './shared/shared.module';
import { MyProfile } from './features/user/components/my-profile/my-profile';
import { OtherProfile } from './features/user/components/other-profile/other-profile';
import { CoreModule } from './core/core.module';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  imports: [
    CoreModule.forRoot(),
    SharedModule,
    HttpClientModule,
    BrowserModule,
    AccessDenied,
    UserInfo,
    MyProfile,
    OtherProfile,
    RouterModule.forRoot(routes) // With standalone application use the provideRouter instead
],
  declarations: [App],
  bootstrap: [App],
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    // provideRouter(routes),
  ],
  exports: [UserInfo],
})
export class AppModule {}
