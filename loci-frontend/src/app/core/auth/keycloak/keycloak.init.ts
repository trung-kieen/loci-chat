import { KeycloakService } from 'keycloak-angular';
import { environment } from '../../../../environments/environments';

// Call initialize function when call keycloak service as provider
export function initializeKeycloak(keycloak: KeycloakService) {
  return () =>
    keycloak.init({
      config: {
        url: environment.keycloak.issuer,
        realm: environment.keycloak.realm,
        clientId: environment.keycloak.clientId,
      },
      initOptions: {
        onLoad: 'login-required', // Redirects to Keycloak login if not authenticated
        // onLoad: 'check-sso',
        checkLoginIframe: true,
      },
      // initOptions: {
      //   onLoad: 'check-sso',
      //   silentCheckSsoRedirectUri:
      //     window.location.origin + '/assets/silent-check-sso.html',
      // },
      loadUserProfileAtStartUp: true,
      bearerExcludedUrls: ['/assets'],
    });
}

