package com.loci.loci_backend.core.groups.infrastructure.secondary.mapper;

import java.time.Instant;

import com.loci.loci_backend.common.mapper.DomainEntityMapper;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.CreateGroupProfileRequest;
import com.loci.loci_backend.core.groups.infrastructure.secondary.entity.GroupEntity;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GroupEntityMapper implements DomainEntityMapper<GroupProfile, GroupEntity> {
  private final MapStructGroupEntityMapper mapper;

  public GroupEntity from(CreateGroupProfileRequest request) {
    return mapper.from(request);
  }


  @Override
  public GroupEntity from(GroupProfile domainObject) {
    return mapper.from(domainObject);
  }


  @Override
  public GroupProfile toDomain(GroupEntity entity) {
    return mapper.toDomain(entity);
  }


}
