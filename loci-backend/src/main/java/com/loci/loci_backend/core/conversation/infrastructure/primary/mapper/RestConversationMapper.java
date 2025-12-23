package com.loci.loci_backend.core.conversation.infrastructure.primary.mapper;

import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.CreateGroupRequest;
import com.loci.loci_backend.core.conversation.infrastructure.primary.payload.RestConversation;
import com.loci.loci_backend.core.conversation.infrastructure.primary.payload.RestCreateGroup;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestConversationMapper {
  private final MapStructConversationMapper mapstruct;


  public RestConversation from(Conversation domain) {
    RestConversation conversation = mapstruct.from(domain);
    conversation.setUnreadCount(0); // fix this
    return conversation;
  }

  public CreateGroupRequest toDomain(RestCreateGroup rest) {
    return mapstruct.from(rest);
  }
}
