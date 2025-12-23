package com.loci.loci_backend.core.conversation.infrastructure.secondary.repository;

import java.util.Optional;

import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface JpaConversationRepository extends JpaRepository<ConversationEntity, Long> {

  @Query("""
      SELECT c
      FROM ConversationEntity c
      WHERE c.deleted = false
      AND (
        c.creatorId = :a
        OR c.creatorId = :b
      )
      """)
  Optional<ConversationEntity> getConversationBetweenUser(@Param("a") Long a, @Param("b") Long b);

  @Query("""
      SELECT COUNT(c) > 0
      FROM ConversationEntity c
      WHERE c.id = :conversationId AND conversationType = 'GROUP'

      """)
  boolean existsGroupConversation(@Param("conversationId") Long conversationId);

}
