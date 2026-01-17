package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import java.util.Set;
import java.util.UUID;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class RestCreateGroup {
  private String groupName;
  private String profileImage;
  private Set<UUID> memberIds;
}
