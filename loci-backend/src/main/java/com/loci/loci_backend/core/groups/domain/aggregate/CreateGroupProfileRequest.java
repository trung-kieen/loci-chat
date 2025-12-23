package com.loci.loci_backend.core.groups.domain.aggregate;

import java.time.Instant;

import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.CreateGroupRequest;
import com.loci.loci_backend.core.conversation.domain.vo.ConversationId;
import com.loci.loci_backend.core.groups.domain.vo.GroupImageUrl;
import com.loci.loci_backend.core.groups.domain.vo.GroupName;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

@Builder(style = BuilderStyle.STAGED)
public record CreateGroupProfileRequest(
    GroupName groupName,
    GroupImageUrl groupProfilePicture,
    ConversationId conversationId,
    Instant lastActive,
    PublicId publicId) {

  public static CreateGroupProfileRequest fromConversation(Conversation conversation,
      CreateGroupRequest request) {
    return CreateGroupProfileRequestBuilder.createGroupProfileRequest()
        .groupName(request.getGroupName())
        .groupProfilePicture(request.getProfileImage())
        .conversationId(conversation.getId())
        .lastActive(Instant.now())
        .publicId(PublicId.random())
    .build();
  }

}
