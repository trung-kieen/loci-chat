package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import java.util.Set;
import java.util.UUID;

import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class RestCreateGroup {
  @Size(min = 3, message = "Group name need at least 3 character")
  private String groupName;
  private String profileImage;
  @Size(min = 2, message = "Group need at least 3 people include you")
  private Set<UUID> memberIds;
}
