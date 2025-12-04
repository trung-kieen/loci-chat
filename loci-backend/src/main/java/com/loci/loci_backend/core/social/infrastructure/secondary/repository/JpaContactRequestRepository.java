package com.loci.loci_backend.core.social.infrastructure.secondary.repository;

import java.util.List;

import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequest;
import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactRequestEntity;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface JpaContactRequestRepository
    extends JpaRepository<ContactRequestEntity, Long>, JpaSpecificationExecutor<ContactRequestEntity> {

  List<ContactRequestEntity> findAll(Specification<ContactRequestEntity> spec);

}
