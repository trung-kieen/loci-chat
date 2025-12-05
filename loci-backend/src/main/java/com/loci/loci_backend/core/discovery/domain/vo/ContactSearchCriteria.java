package com.loci.loci_backend.core.discovery.domain.vo;

import lombok.Getter;

@Getter
public class ContactSearchCriteria {
  private final String keyword;
  private final String currentUsername;

  public ContactSearchCriteria(String keyword, String searchUsername) {
    this.keyword = keyword;
    this.currentUsername = searchUsername;
  }


}
