package com.loci.loci_backend.core.discovery.infrastructure.primary.mapper;

import com.loci.loci_backend.common.ddd.infrastructure.mapper.ValueObjectTypeConverter;
import com.loci.loci_backend.core.discovery.domain.aggregate.ContactProfile;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestContactProfile;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = ValueObjectTypeConverter.class)
public interface MapStructRestContactProfileMapper {

  @Mapping(source = "publicId", target = "userId")
  public RestContactProfile from(ContactProfile domain);
}
