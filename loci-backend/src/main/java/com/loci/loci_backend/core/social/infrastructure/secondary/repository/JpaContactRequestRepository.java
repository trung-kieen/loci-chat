package com.loci.loci_backend.core.social.infrastructure.secondary.repository;

import java.util.List;
import java.util.Optional;

import com.loci.loci_backend.core.discovery.infrastructure.secondary.dto.ContactRequestRelation;
import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactRequestEntity;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface JpaContactRequestRepository
    extends JpaRepository<ContactRequestEntity, Long>, JpaSpecificationExecutor<ContactRequestEntity> {

  List<ContactRequestEntity> findAll(Specification<ContactRequestEntity> spec);

  @Query("""
      SELECT new com.loci.loci_backend.core.discovery.infrastructure.secondary.dto.ContactRequestRelation(
          r.id,
          r.requestUserId,
          r.receiverUserId
      )
      FROM ContactRequestEntity r
      WHERE (r.requestUserId = :currentUserId AND r.receiverUserId IN (:targetUserIds))
         OR (r.receiverUserId = :currentUserId AND r.requestUserId IN (:targetUserIds))
      """)
  public List<ContactRequestRelation> findInvolving(
      @Param("currentUserId") Long currentUserId,
      @Param("targetUserIds") List<Long> targetUserIds);

  @Query("""
      SELECT new com.loci.loci_backend.core.discovery.infrastructure.secondary.dto.ContactRequestRelation(
          r.id, r.requestUserId, r.receiverUserId
      )
      FROM ContactRequestEntity r
      WHERE (r.requestUserId = :currentUserId AND r.receiverUserId = :targetId)
         OR (r.receiverUserId = :currentUserId AND r.requestUserId = :targetId)
      """)
  Optional<ContactRequestRelation> findRequestBetween(
      @Param("currentUserId") Long currentUserId,
      @Param("targetId") Long targetId);
}
