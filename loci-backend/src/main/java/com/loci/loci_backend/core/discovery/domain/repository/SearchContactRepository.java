package com.loci.loci_backend.core.discovery.domain.repository;

import com.loci.loci_backend.core.discovery.domain.aggregate.SearchContact;
import com.loci.loci_backend.core.discovery.domain.vo.ContactSearchCriteria;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface SearchContactRepository {

  Page<SearchContact> searchContacts(ContactSearchCriteria criteria, Pageable pageable);
}
