package com.loci.loci_backend.core.conversation.infrastructure.secondary.repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.validation.domain.Assert;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.repository.ConversationRepository;
import com.loci.loci_backend.core.conversation.domain.vo.ConversationId;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationEntity;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationParticipantEntity;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.mapper.ConversationEntityMapper;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.mapper.ParticipantEntityMapper;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SpringDataConversationRepository implements ConversationRepository {
  private final JpaConversationRepository repository;
  private final JpaConversationParticipantRepository participantRepository;
  private final ConversationEntityMapper mapper;
  private final ParticipantEntityMapper participantMapper;

  @Override
  public Optional<Conversation> getOneToOne(User a, User b) {

    Optional<ConversationEntity> entity = repository.getConversationBetweenUser(a.getDbId().value(),
        b.getDbId().value());
    return entity.map(mapper::toDomain);

  }

  /**
   * Create new conversation and assign member to conversation
   */
  @Transactional(readOnly = false)
  @Override
  public Conversation save(Conversation conversation) {
    ConversationEntity entity = mapper.from(conversation);

    // Create new conversation
    ConversationEntity persistenceConversation = repository.save(entity);
    Long conversationId = persistenceConversation.getId();

    // assign new conversation id to participant for mannual binding foreign key
    Set<ConversationParticipantEntity> participantEntities = conversation.getParticipants().stream()
        .map((member) -> {
          ConversationParticipantEntity memberEntity = participantMapper.from(member);
          memberEntity.setConversationId(conversationId);
          return memberEntity;

        }).collect(Collectors.toSet());

    Assert.field("conversation participant", participantEntities).notEmpty();

    List<ConversationParticipantEntity> persistencePariticipants = participantRepository
        .saveAllAndFlush(participantEntities);

    return mapper.toDomain(persistenceConversation, persistencePariticipants);
  }

  @Override
  public boolean existsGroupConversation(ConversationId conversationId) {
    return repository.existsGroupConversation(conversationId.value());
  }

}
