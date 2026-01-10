package com.loci.loci_backend.core.discovery.application;

import com.loci.loci_backend.common.ddd.infrastructure.stereotype.ApplicationService;
import com.loci.loci_backend.core.discovery.domain.aggregate.ContactProfileList;
import com.loci.loci_backend.core.discovery.domain.service.DiscoveryService;
import com.loci.loci_backend.core.discovery.domain.service.PersonalizedRecommendationService;
import com.loci.loci_backend.core.discovery.domain.vo.SuggestFriendCriteria;
import com.loci.loci_backend.core.discovery.domain.vo.UserSearchCriteria;

import org.springframework.data.domain.Pageable;

import lombok.RequiredArgsConstructor;

@ApplicationService
@RequiredArgsConstructor
public class DiscoveryApplicationService {
  private final DiscoveryService discoveryService;
  private final PersonalizedRecommendationService recommendationService;

  public ContactProfileList discoveryContacts(UserSearchCriteria criteria, Pageable pageable
      ) {
    return discoveryService.discoveryContacts(criteria, pageable);
  }

  public ContactProfileList suggestFriends(SuggestFriendCriteria criteria, Pageable pageable) {
    return recommendationService.suggestFriends(criteria, pageable);
  }
}
