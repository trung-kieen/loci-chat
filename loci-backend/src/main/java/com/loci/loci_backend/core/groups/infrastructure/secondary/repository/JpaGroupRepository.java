package com.loci.loci_backend.core.groups.infrastructure.secondary.repository;

import java.util.Optional;

import com.loci.loci_backend.core.groups.infrastructure.secondary.entity.GroupEntity;

import org.springframework.data.jpa.repository.JpaRepository;

public interface JpaGroupRepository extends JpaRepository<GroupEntity, Long> {

  Optional<GroupEntity> findByConversationId(Long conversationId);



}
