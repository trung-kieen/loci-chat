package com.loci.loci_backend.core.conversation.domain.aggregate;

import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GroupConversationInfo {
  private final Conversation chat;
  private final GroupProfile group;
}
