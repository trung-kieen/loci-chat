package com.loci.loci_backend.common.migration.infrastructure.mapper;

import com.loci.loci_backend.common.migration.domain.aggregate.KeycloakUser;
import com.loci.loci_backend.common.migration.domain.service.MigrationMapper;
import com.loci.loci_backend.common.user.domain.aggregate.User;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MigrationMapperImpl implements MigrationMapper {
  private final MapStructMigrationMapper mapper;

  @Override
  public KeycloakUser toKeycloakUser(User user) {
    return mapper.toKeycloakUser(user);
  }

}
