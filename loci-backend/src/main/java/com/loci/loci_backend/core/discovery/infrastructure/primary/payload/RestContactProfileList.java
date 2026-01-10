package com.loci.loci_backend.core.discovery.infrastructure.primary.payload;

import org.springframework.data.domain.Page;

import lombok.Data;

@Data
public class RestContactProfileList {
  private final Page<RestContactProfile> contacts;

  public RestContactProfileList(Page<RestContactProfile> contacts) {
    this.contacts = contacts;
  }

}
