package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import java.time.Instant;
import java.util.UUID;

import com.loci.loci_backend.core.conversation.infrastructure.secondary.enumeration.ConversationTypeEnum;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RestCreateGroupResponse {

  private UUID conversationId;
  private ConversationTypeEnum type;
  private String name;
  private String inviteLink;
  private Instant createdAt;

}
