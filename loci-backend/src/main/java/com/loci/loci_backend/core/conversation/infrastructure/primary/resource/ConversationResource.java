package com.loci.loci_backend.core.conversation.infrastructure.primary.resource;

import java.util.UUID;

import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.conversation.application.ConversationApplicationService;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.CreateGroupRequest;
import com.loci.loci_backend.core.conversation.infrastructure.primary.mapper.RestConversationMapper;
import com.loci.loci_backend.core.conversation.infrastructure.primary.payload.RestConversation;
import com.loci.loci_backend.core.conversation.infrastructure.primary.payload.RestCreateGroup;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/conversations")
public class ConversationResource {

  private final ConversationApplicationService conversationService;
  private final RestConversationMapper mapper;

  @GetMapping
  public ResponseEntity<RestConversation> getConversation(@RequestParam("userId") UUID userPublicId) {
    PublicId targetUserId = new PublicId(userPublicId);
    Conversation conversation = conversationService.getConversationByUser(targetUserId);

    RestConversation restResponse = mapper.from(conversation);
    return ResponseEntity.ok(restResponse);
  }

  @PostMapping("/group")
  public ResponseEntity<RestConversation> createGroupConveration(@RequestBody RestCreateGroup rest) {
    CreateGroupRequest request = mapper.toDomain(rest);
    Conversation conversation = conversationService.createGroupConversation(request);

    RestConversation restResponse = mapper.from(conversation);
    return ResponseEntity.ok(restResponse);
  }

  @PostMapping
  public ResponseEntity<RestConversation> createDMConversation(@RequestParam("userId") UUID userPublicId) {
    PublicId targetUserId = new PublicId(userPublicId);
    Conversation conversation = conversationService.createConversationWithUser(targetUserId);

    RestConversation restResponse = mapper.from(conversation);
    return ResponseEntity.ok(restResponse);
  }

}
