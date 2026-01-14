package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import java.util.UUID;

import com.loci.loci_backend.core.conversation.infrastructure.secondary.enumeration.ConversationTypeEnum;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public class RestChat {

  private UUID conversationId; // only pubic id
  private ConversationTypeEnum type;

  private Long unreadCount;
  // TODO: preview
  private RestMessage lastMessage;

  private RestGroupChatInfo groupMetadata;
  private RestDirectChatInfo dmMetadata;

}
