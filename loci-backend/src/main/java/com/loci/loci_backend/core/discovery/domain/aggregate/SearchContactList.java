package com.loci.loci_backend.core.discovery.domain.aggregate;

import org.springframework.data.domain.Page;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class SearchContactList {

  private final Page<SearchContact> contacts;

}
