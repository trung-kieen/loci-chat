package com.loci.loci_backend.core.social.domain.aggregate;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.vo.PublicId;

import org.jilt.Builder;

import lombok.Data;

@Data
public class CreateContactRequest {
  private PublicId receiverPublicId;
  private Username senderUsername;
  @Builder
  public CreateContactRequest(PublicId receiverPublicId, Username sendUsername) {
    this.receiverPublicId = receiverPublicId;
    this.senderUsername = sendUsername;
  }

}
