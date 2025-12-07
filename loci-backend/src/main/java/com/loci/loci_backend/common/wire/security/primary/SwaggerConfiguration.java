package com.loci.loci_backend.common.wire.security.primary;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.security.SecuritySchemes;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
    info = @Info(title = "Loci API", version = "1.1", contact = @Contact(name = "trung-kieen")),
    security = {
      // @SecurityRequirement(name = "basicAuth"),
      @SecurityRequirement(name = "bearerToken")
    })
@SecuritySchemes({
  // @SecurityScheme(name = "basicAuth", type = SecuritySchemeType.HTTP, scheme = "basic"),
  @SecurityScheme(
      name = "bearerToken",
      type = SecuritySchemeType.HTTP,
      scheme = "bearer",
      bearerFormat = "JWT")
})
public class SwaggerConfiguration {
}
