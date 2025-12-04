package com.loci.loci_backend.core.social.infrastructure.primary.payload;

import java.util.UUID;

import org.jilt.Builder;

import lombok.Data;

@Data
public class RestFriendRequestResponse {
  private Long contactRequestId;
  private UUID receiverPublicId;

  @Builder
  public RestFriendRequestResponse(Long contactRequestId, UUID receiverPublicId) {
    this.contactRequestId = contactRequestId;
    this.receiverPublicId = receiverPublicId;
  }


}
