package com.loci.loci_backend.core.groups.infrastructure.primary.mapper;

import com.loci.loci_backend.common.mapper.ValueObjectTypeConverter;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfileChanges;
import com.loci.loci_backend.core.groups.infrastructure.primary.payload.RestGroupProfile;
import com.loci.loci_backend.core.groups.infrastructure.primary.payload.RestGroupProfileChanges;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = ValueObjectTypeConverter.class)
public interface MapStructRestGroupMapper {

  @Mapping(source = "groupProfilePicture", target = "groupPictureUrl")
  @Mapping(source = "publicId", target = "groupId")
  public RestGroupProfile from(GroupProfile domain);

  public GroupProfileChanges toDomain(RestGroupProfileChanges restModel);

}
