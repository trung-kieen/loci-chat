package com.loci.loci_backend.core.social.infrastructure.primary.payload;

import java.util.UUID;

import lombok.Data;

@Data
public class RestSendContactRequest {
  private UUID receiverPublicId;
}
