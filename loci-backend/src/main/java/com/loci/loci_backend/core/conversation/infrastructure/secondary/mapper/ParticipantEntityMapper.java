package com.loci.loci_backend.core.conversation.infrastructure.secondary.mapper;

import com.loci.loci_backend.common.mapper.DomainEntityMapper;
import com.loci.loci_backend.core.conversation.domain.aggregate.Participant;
import com.loci.loci_backend.core.conversation.domain.vo.ConversationId;
import com.loci.loci_backend.core.conversation.domain.vo.ConversationPublicId;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationEntity;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationParticipantEntity;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ParticipantEntityMapper implements DomainEntityMapper<Participant, ConversationParticipantEntity> {
  private final MapStructParticipantEntityMapper mapstruct;

  @Override
  public Participant toDomain(ConversationParticipantEntity entity) {
    return mapstruct.toDomain(entity);
  }

  public Participant toDomain(ConversationParticipantEntity entity, ConversationEntity conversationEntity) {
    Participant participant = mapstruct.toDomain(entity);
    participant.setConversationId(new ConversationId(conversationEntity.getId()));
    participant.setConversationPublicId(new ConversationPublicId(conversationEntity.getPublicId()));
    return participant;
  }

  @Override
  public ConversationParticipantEntity from(Participant domainObject) {
    return mapstruct.from(domainObject);
  }

}
