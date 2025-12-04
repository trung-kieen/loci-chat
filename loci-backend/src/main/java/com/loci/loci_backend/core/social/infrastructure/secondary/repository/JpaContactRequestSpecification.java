package com.loci.loci_backend.core.social.infrastructure.secondary.repository;

import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactEntity;
import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactRequestEntity;

import org.springframework.data.jpa.domain.Specification;

public class JpaContactRequestSpecification {

  public static Specification<ContactRequestEntity> searchContactRequest(Long userId0, Long userId1) {
    return (root, query, cb) -> {
      if (userId0 == null || userId1== null) {
        return cb.disjunction();
      }

      return cb.or(
          cb.and(
              cb.equal(root.get("requester").get("id"), userId0),
              cb.equal(root.get("receiver").get("id"), userId1)),
          cb.and(
              cb.equal(root.get("requester").get("id"), userId1),
              cb.equal(root.get("receiver").get("id"), userId0)));
    };
  }

}
