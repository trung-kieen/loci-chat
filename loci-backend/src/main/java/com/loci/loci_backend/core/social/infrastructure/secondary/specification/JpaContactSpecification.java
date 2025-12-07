package com.loci.loci_backend.core.social.infrastructure.secondary.specification;

import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactEntity;

import org.springframework.data.jpa.domain.Specification;

public class JpaContactSpecification {

  public static Specification<ContactEntity> searchContact(Long userId0, Long userId1) {
    return (root, query, cb) -> {
      if (userId0 == null || userId1== null) {
        return cb.disjunction();
      }

      return cb.or(
          cb.and(
              cb.equal(root.get("owningUserId"), userId0),
              cb.equal(root.get("contactUserId"), userId1)),
          cb.and(
              cb.equal(root.get("owningUserId"), userId1),
              cb.equal(root.get("contactUserId"), userId0)));
    };
  }

}
