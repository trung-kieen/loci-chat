package com.loci.loci_backend;

import java.util.HashMap;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;

@TestConfiguration
public class TestSecurityConfig {

  @Bean
  @Primary
  public JwtDecoder jwtDecoder() {
    return token -> {
      var headers = new HashMap<String, Object>();
      headers.put("alg", "none");

      var claims = new HashMap<String, Object>();
      claims.put("sub", "test-user");
      claims.put("scope", "openid profile");

      return Jwt.withTokenValue(token)
          .headers(h -> h.putAll(headers))
          .claims(c -> c.putAll(claims))
          .build();
    };
  }
}
