package com.loci.loci_backend.core.conversation.application;

import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.CreateGroupRequest;
import com.loci.loci_backend.core.conversation.domain.service.ConversationManager;
import com.loci.loci_backend.core.groups.application.GroupApplicationService;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.CreateGroupProfileRequest;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class ConversationApplicationService {
  private final ConversationManager conversationManager;
  private final GroupApplicationService groupApplicationService;

  public Conversation getConversationByUser(PublicId targetUserId) {
    return conversationManager.getConversation(targetUserId);
  }

  public Conversation createConversationWithUser(PublicId targetUserId) {
    return conversationManager.createConversation(targetUserId);
  }

  public Conversation createGroupConversation(CreateGroupRequest request) {
    Conversation currentUserConversation = conversationManager.createGroupConversation();

    request.provideMandatoryField();

    CreateGroupProfileRequest createProfileRequest = CreateGroupProfileRequest
        .fromConversation(currentUserConversation, request);

    GroupProfile profile = groupApplicationService.createGroupProfile(createProfileRequest);
    log.debug("Create group profile {} for conversation {}", profile, currentUserConversation);

    return currentUserConversation;
  }
}
