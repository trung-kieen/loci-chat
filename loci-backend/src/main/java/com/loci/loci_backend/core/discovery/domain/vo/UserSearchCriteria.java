package com.loci.loci_backend.core.discovery.domain.vo;

import com.loci.loci_backend.common.authentication.domain.Username;

import lombok.Data;

@Data
public class UserSearchCriteria {
  private final SearchQuery keyword;
  private final Username currentUsername;

  public UserSearchCriteria(SearchQuery keyword, Username username) {
    this.keyword = keyword;
    this.currentUsername = username;
  }
}
