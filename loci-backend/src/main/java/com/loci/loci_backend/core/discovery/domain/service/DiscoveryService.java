package com.loci.loci_backend.core.discovery.domain.service;

import com.loci.loci_backend.core.discovery.domain.aggregate.SearchContact;
import com.loci.loci_backend.core.discovery.domain.repository.SearchContactRepository;
import com.loci.loci_backend.core.discovery.domain.vo.ContactSearchCriteria;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DiscoveryService {

  private final SearchContactRepository repository;

  public Page<SearchContact> discoveryContacts(ContactSearchCriteria criteria, Pageable pageable) {
    return repository.searchContacts(criteria, pageable);
  }

  void discoveryGroups() {
  }

}
