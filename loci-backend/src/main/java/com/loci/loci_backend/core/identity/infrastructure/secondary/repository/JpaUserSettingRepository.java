package com.loci.loci_backend.core.identity.infrastructure.secondary.repository;

import com.loci.loci_backend.core.identity.infrastructure.secondary.entity.UserSettingEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface JpaUserSettingRepository extends JpaRepository<UserSettingEntity, Long> {
  @Query("""
    SELECT s.profileVisibility
    FROM UserSettingEntity s
    WHERE s.id = :userId
    """)
  boolean isProfileVisible(@Param("userId") Long userId);

}
