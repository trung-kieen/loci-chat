package com.loci.loci_backend.core.discovery.application;

import com.loci.loci_backend.common.authentication.domain.KeycloakPrincipal;
import com.loci.loci_backend.core.discovery.domain.aggregate.SearchContact;
import com.loci.loci_backend.core.discovery.domain.service.DiscoveryService;
import com.loci.loci_backend.core.discovery.domain.vo.ContactSearchCriteria;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DiscoveryApplicationService {
  private final DiscoveryService discoveryService;

  public Page<SearchContact> discoveryContacts(ContactSearchCriteria criteria, Pageable pageable,
      KeycloakPrincipal principal) {
    return discoveryService.discoveryContacts(criteria, pageable, principal);
  }

}
