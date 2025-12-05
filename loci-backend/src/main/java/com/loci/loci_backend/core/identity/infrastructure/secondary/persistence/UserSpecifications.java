package com.loci.loci_backend.core.identity.infrastructure.secondary.persistence;

import com.loci.loci_backend.common.user.infrastructure.secondary.entity.UserEntity;

import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;

public class UserSpecifications {

  public static Specification<UserEntity> searchActiveUsers(String keyword, String currentUsername) {
    // TODO: search for username, email, name by elastic search
    return (Root<UserEntity> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {

      // Username search predicate
      String username = (keyword == null || keyword.isBlank()) ? "" : keyword;
      String lowerKeyword = "%" + username.toLowerCase() + "%";
      Predicate usernamePredicate = cb.like(cb.lower(root.get("username")), lowerKeyword);

      // Exclude current user predicate (handles null/blank)
      Predicate excludeCurrentUserPredicate = (currentUsername != null && !currentUsername.isBlank())
          ? cb.notEqual(root.get("username"), currentUsername)
          : cb.conjunction();

      // Combine predicates
      return cb.and(usernamePredicate, excludeCurrentUserPredicate);
    };
  }
}
