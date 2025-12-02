package com.loci.loci_backend.common.migration.infrastructure.mapper;

import com.loci.loci_backend.common.migration.domain.aggregate.KeycloakUser;
import com.loci.loci_backend.common.user.domain.aggregate.User;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring") // allow inject or access via INSTANCE
public interface MapStructMigrationMapper {
  @Mapping(source = "firstname", target = "firstName")
  @Mapping(source = "lastname", target = "lastName")
  @Mapping(target = "enabled", ignore = true)
  public KeycloakUser toKeycloakUser(User user);





}
