package com.loci.loci_backend.common.wire.security.primary;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;

@Configuration
public class SwaggerConfig {
  private static final String OAUTH_SCHEME_BEARER = "bearerAuth";

  @Bean
  public OpenAPI customizeOpenAPI() {
    return new OpenAPI()
        .addSecurityItem(new SecurityRequirement()
            .addList(OAUTH_SCHEME_BEARER))
        .components(new Components()
            .addSecuritySchemes(OAUTH_SCHEME_BEARER, new SecurityScheme()
                .name(OAUTH_SCHEME_BEARER)
                .type(SecurityScheme.Type.HTTP)
                .scheme("bearer")
                .bearerFormat("JWT")));
  }

}
