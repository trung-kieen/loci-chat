export const environment = {
  production: false,
  socketEndpoint: 'wss://localhost:8080/ws',
  apiUrl: '//localhost:8080/api/v1',
  keycloak: {
    // Keycloak url
    issuer: 'http://localhost:9090',
    // Realm
    realm: 'loci-realm',
    clientId: 'angular',
  },
};
