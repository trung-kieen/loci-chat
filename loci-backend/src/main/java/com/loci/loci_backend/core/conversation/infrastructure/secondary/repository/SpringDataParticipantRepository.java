package com.loci.loci_backend.core.conversation.infrastructure.secondary.repository;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.Participant;
import com.loci.loci_backend.core.conversation.domain.repository.ParticipantRepository;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationParticipantEntity;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.mapper.ParticipantEntityMapper;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SpringDataParticipantRepository implements ParticipantRepository {

  private final JpaConversationParticipantRepository repository;
  private final ParticipantEntityMapper mapper;

  @Transactional(readOnly = false)
  @Override
  public List<Participant> addParticipants(Conversation conversation, Collection<Participant> participants) {

    Set<ConversationParticipantEntity> entities = participants.stream().map(mapper::from).collect(Collectors.toSet());
    List<ConversationParticipantEntity> savedEntities = repository.saveAllAndFlush(entities);

    return mapper.toDomain(savedEntities);
  }

}
