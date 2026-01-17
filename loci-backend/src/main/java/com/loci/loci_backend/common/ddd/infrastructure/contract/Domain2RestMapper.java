package com.loci.loci_backend.common.ddd.infrastructure.contract;

import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;

public interface Domain2RestMapper<D, R> {

  R from(D domain);

  default Set<R> from(Set<D> domainSet) {
    if (domainSet == null) {
      return null;
    }
    return domainSet.stream()
        .map(this::from)
        .collect(Collectors.toSet());
  }

  default Page<R> from(Page<D> domainPage) {
    if (domainPage == null) {
      return null;
    }
    return domainPage.map(this::from);
  }
}
