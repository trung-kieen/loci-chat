package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import java.time.Instant;
import java.util.UUID;

import com.loci.loci_backend.core.conversation.domain.vo.ConversationType;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RestConversation {
  private UUID id;
  private ConversationType conversationType;
  private Integer unreadCount;
  private RestMessage lastMessage;
  private Instant createdDate;

}
