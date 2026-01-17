package com.loci.loci_backend.core.groups.infrastructure.primary.payload;

import java.util.UUID;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RestGroupProfile {
  private UUID groupId;

  private String groupName;

  private String groupPictureUrl;

  // Optional
  // public UUID conversationId;

}
