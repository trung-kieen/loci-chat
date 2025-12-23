package com.loci.loci_backend.core.conversation.infrastructure.secondary.mapper;

import java.util.Collection;
import java.util.Set;

import com.loci.loci_backend.common.mapper.DomainEntityMapper;
import com.loci.loci_backend.common.validation.domain.Assert;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.Participant;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationEntity;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationParticipantEntity;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ConversationEntityMapper implements DomainEntityMapper<Conversation, ConversationEntity> {
  private final MapStructConversationEntityMapper mapstruct;
  private final ParticipantEntityMapper participantMapper;

  @Override
  public Conversation toDomain(ConversationEntity entity) {
    return mapstruct.toDomain(entity);
  }

  public Conversation toDomain(ConversationEntity entity,
      Collection<ConversationParticipantEntity> participantEntities) {
    Conversation conversation = mapstruct.toDomain(entity);
    Set<Participant> participants = participantMapper.toDomain(participantEntities);

    conversation.setParticipants(participants);

    return conversation;
  }

  @Override
  public ConversationEntity from(Conversation domainObject) {
    return mapstruct.from(domainObject);
  }

}
