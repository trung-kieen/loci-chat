package com.loci.loci_backend.core.discovery.infrastructure.secondary.dto;

import com.loci.loci_backend.core.discovery.domain.vo.FriendshipStatus;

public interface UserRelation {

  public FriendshipStatus friendshipStatusWithUser(Long currentUserId);

  public Long getOpponent(Long currentUserId);
}
