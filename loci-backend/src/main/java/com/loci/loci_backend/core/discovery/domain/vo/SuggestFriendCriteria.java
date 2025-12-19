package com.loci.loci_backend.core.discovery.domain.vo;

import com.loci.loci_backend.common.authentication.domain.Username;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SuggestFriendCriteria {

  private final Username currentUsername;

}
