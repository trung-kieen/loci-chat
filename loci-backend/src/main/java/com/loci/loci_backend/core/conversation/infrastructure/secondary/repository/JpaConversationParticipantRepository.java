package com.loci.loci_backend.core.conversation.infrastructure.secondary.repository;

import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationParticipantEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface JpaConversationParticipantRepository extends JpaRepository<ConversationParticipantEntity, Long> {

}
