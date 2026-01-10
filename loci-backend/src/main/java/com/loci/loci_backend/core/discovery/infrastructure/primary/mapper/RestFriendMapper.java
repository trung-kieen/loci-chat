package com.loci.loci_backend.core.discovery.infrastructure.primary.mapper;

import java.util.List;

import com.loci.loci_backend.common.ddd.infrastructure.stereotype.PrimaryMapper;
import com.loci.loci_backend.core.discovery.domain.aggregate.Friend;
import com.loci.loci_backend.core.discovery.domain.aggregate.FriendList;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestFriend;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestFriendList;

import lombok.RequiredArgsConstructor;

@PrimaryMapper
@RequiredArgsConstructor
public class RestFriendMapper {
  private final MapStructRestFriendMapper mapstruct;

  public RestFriend from(Friend domain) {
    return mapstruct.from(domain);
  }

  public RestFriendList from(FriendList models) {
    List<RestFriend> friends = models.getFriends().stream()
        .map(this::from).toList();
    return new RestFriendList(friends);
  }

}
