package com.loci.loci_backend.core.discovery.infrastructure.primary.mapper;

import com.loci.loci_backend.core.discovery.domain.aggregate.SearchContact;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestSearchContact;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class RestDicoveryContactMapper {
  private final MapStructDiscoveryRestContactMapper contactMapper;

  public RestSearchContact from(SearchContact contact) {
    return contactMapper.from(contact);
  }

  public Page<RestSearchContact> from(Page<SearchContact> contactPage) {
    return contactPage.map(this::from);
  }

}
