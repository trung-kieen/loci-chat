package com.loci.loci_backend.core.discovery.infrastructure.secondary.dto;

import com.loci.loci_backend.core.discovery.domain.vo.FriendshipStatus;

public record ContactRelation(Long id, Long owningUserId, Long contactUserId, Long blockedByUserId)
    implements UserRelation {

  /**
   * return FriendshipStatus state or Unknown
   */
  public FriendshipStatus friendshipStatusWithUser(Long currentUserId) {
    if (blockedByUserId != null) {
      // Block is current user
      if (this.blockedByUserId == currentUserId) {
        return FriendshipStatus.BLOCKED;
        // block is opponent
      }
      return FriendshipStatus.BLOCKED_BY_THEM;

    }
    if (this.owningUserId == currentUserId || this.contactUserId == currentUserId) {
      return FriendshipStatus.CONNECTED;
    }
    return FriendshipStatus.UNKNOWN;

  }

  public Long getOpponent(Long currentUserId) {
    if (this.owningUserId == currentUserId) {
      return this.contactUserId;
    }
    return this.owningUserId;
  }
}
