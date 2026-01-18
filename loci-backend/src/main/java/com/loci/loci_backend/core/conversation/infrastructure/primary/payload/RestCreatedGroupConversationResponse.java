package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import com.loci.loci_backend.core.groups.infrastructure.primary.payload.RestGroupProfile;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

import lombok.Data;

@Data
public class RestCreatedGroupConversationResponse {
  private final RestChatReference chat;
  private final RestGroupProfile group;

  @Builder(style = BuilderStyle.STAGED)
  public RestCreatedGroupConversationResponse(RestChatReference chat, RestGroupProfile group) {
    this.chat = chat;
    this.group = group;
  }

}
