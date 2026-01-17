package com.loci.loci_backend.core.groups.domain.factory;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import com.loci.loci_backend.common.user.domain.vo.UserDBId;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.Participant;
import com.loci.loci_backend.core.conversation.domain.aggregate.ParticipantBuilder;
import com.loci.loci_backend.core.conversation.domain.vo.ParticipantRole;

public class ConversationParticipantFactory {

  /**
   * Return mutable collection of new group member with role Member in
   * conversation
   */
  public static List<Participant> groupMembers(Conversation conversation, Collection<UserDBId> memberIds) {
    return memberIds.stream().map(id -> {
      return ConversationParticipantFactory.inConversation(conversation, ParticipantRole.MEMBER, id);
    }).collect(Collectors.toList());
  }

  /**
   * Participant without register to conversation
   */
  public static Participant unmanagerParticipant(UserDBId userId, ParticipantRole role) {
    return ParticipantBuilder.participant()
        .id(null)
        .userId(userId)
        .role(role)
        .lastReadMessageId(null)
        .conversationId(null)
        .conversationPublicId(null)
        .build();

  }

  /**
   * Declare new participant in conversation
   */
  public static Participant inConversation(Conversation conversation, ParticipantRole role, UserDBId userId) {
    return ParticipantBuilder.participant()
        .id(null)
        .userId(userId)
        .role(role)
        .lastReadMessageId(null)
        .conversationId(conversation.getId())
        .conversationPublicId(conversation.getPublicId())
        .build();
  }

  public static Participant admin(Conversation conversation, UserDBId userId) {
    return ParticipantBuilder.participant()
        .id(null)
        .userId(userId)
        .role(ParticipantRole.ADMIN)
        .lastReadMessageId(null)
        .conversationId(conversation.getId())
        .conversationPublicId(conversation.getPublicId())
        .build();
  }
}
