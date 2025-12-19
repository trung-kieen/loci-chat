package com.loci.loci_backend.core.discovery.infrastructure.primary.payload;

import org.springframework.data.domain.Page;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RestSearchContactList {
  private final Page<RestSearchContact> contacts;

}
