package com.loci.loci_backend.core.discovery.infrastructure.secondary.dto;

import com.loci.loci_backend.core.discovery.domain.vo.FriendshipStatus;

public record ContactRequestRelation(Long id, Long requestUserId, Long receiverUserId) implements UserRelation {

  @Override
  public FriendshipStatus friendshipStatusWithUser(Long currentUserId) {
    if (currentUserId == this.requestUserId) {
      return FriendshipStatus.PENDING_REQUEST;
    }
    if (currentUserId == this.receiverUserId) {
      return FriendshipStatus.REQUEST_RECEIVED;
    }
    return FriendshipStatus.UNKNOWN;
  }

  @Override
  public Long getOpponent(Long currentUserId) {
    if (currentUserId == this.receiverUserId) {
      return this.requestUserId;
    }
    return this.receiverUserId;
  }
}
