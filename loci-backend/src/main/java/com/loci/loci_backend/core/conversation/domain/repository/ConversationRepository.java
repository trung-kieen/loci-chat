package com.loci.loci_backend.core.conversation.domain.repository;

import java.util.Optional;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.vo.ConversationId;

public interface ConversationRepository {

  public Optional<Conversation> getOneToOne(User a, User b);

  public Conversation save(Conversation conversation);

  public boolean existsGroupConversation(ConversationId conversationId);
}
