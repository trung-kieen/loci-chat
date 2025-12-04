package com.loci.loci_backend.core.discovery.infrastructure.primary.mapper;

import com.loci.loci_backend.common.util.ValueObjectTypeConverter;
import com.loci.loci_backend.core.discovery.domain.aggregate.SearchContact;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestSearchContact;

import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = ValueObjectTypeConverter.class)
public interface MapStructDiscoveryRestContactMapper {
  public RestSearchContact from(SearchContact contact);

}
