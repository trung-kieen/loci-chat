package com.loci.loci_backend.core.discovery.infrastructure.primary.mapper;

import com.loci.loci_backend.common.ddd.infrastructure.contract.Domain2RestMapper;
import com.loci.loci_backend.common.ddd.infrastructure.stereotype.PrimaryMapper;
import com.loci.loci_backend.core.discovery.domain.aggregate.Friend;
import com.loci.loci_backend.core.discovery.domain.aggregate.FriendList;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestFriend;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestFriendList;

import lombok.RequiredArgsConstructor;

@PrimaryMapper
@RequiredArgsConstructor
public class RestFriendMapper implements Domain2RestMapper<Friend, RestFriend> {
  private final MapStructRestFriendMapper mapstruct;

  public RestFriend from(Friend domain) {
    return mapstruct.from(domain);
  }

  public RestFriendList from(FriendList models) {
    return new RestFriendList(this.from(models.getFriends()));
  }

}
