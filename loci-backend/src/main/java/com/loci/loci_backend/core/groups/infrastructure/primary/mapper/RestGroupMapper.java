package com.loci.loci_backend.core.groups.infrastructure.primary.mapper;

import com.loci.loci_backend.common.ddd.infrastructure.contract.Domain2RestMapper;
import com.loci.loci_backend.common.ddd.infrastructure.contract.Rest2DomainMapper;
import com.loci.loci_backend.common.ddd.infrastructure.stereotype.PrimaryMapper;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfileChanges;
import com.loci.loci_backend.core.groups.infrastructure.primary.payload.RestGroupProfile;
import com.loci.loci_backend.core.groups.infrastructure.primary.payload.RestGroupProfileChanges;

import lombok.RequiredArgsConstructor;

@PrimaryMapper
@RequiredArgsConstructor
public class RestGroupMapper implements Domain2RestMapper<GroupProfile, RestGroupProfile>,
    Rest2DomainMapper<RestGroupProfileChanges, GroupProfileChanges> {
  private final MapStructRestGroupMapper mapstruct;

  @Override
  public RestGroupProfile from(GroupProfile domain) {
    return mapstruct.from(domain);
  }

  @Override
  public GroupProfileChanges toDomain(RestGroupProfileChanges restModel) {
    return mapstruct.toDomain(restModel);
  }

}
