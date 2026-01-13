package com.loci.loci_backend.common.authentication.domain;

import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.loci.loci_backend.common.validation.domain.Assert;

import lombok.Getter;

@Getter
public enum Role {

  // use lowercase for consistence with keycloak and spring security
  ADMIN("admin"),
  USER("user"),
  ANONYMOUS("anonymous"),
  UNKNOWN("unknown");

  private String value;

  private static final String PREFIX = "ROLE_";
  private static final Map<String, Role> ROLES = buildRoles();

  // Available role to map of <String, Role>
  private static Map<String, Role> buildRoles() {
    return Stream.of(values()).collect(Collectors.toUnmodifiableMap(Role::key, Function.identity()));
  }

  private Role(String value) {
    this.value = value;
  }

  /*
   * Return the name of role in spring app
   */
  public String key() {
    return PREFIX + value;
  }

  public static Role from(String role) {
    Assert.notBlank("role", role);

    return ROLES.getOrDefault(role, UNKNOWN);
  }

  public static Role fromKeycloak(String role) {
    return ROLES.getOrDefault(PREFIX + role, UNKNOWN);
  }

}
