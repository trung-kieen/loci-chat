package com.loci.loci_backend.core.discovery.domain.service;

import java.util.List;

import com.loci.loci_backend.common.authentication.domain.CurrentUser;
import com.loci.loci_backend.common.ddd.infrastructure.stereotype.DomainService;
import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.repository.UserRepository;
import com.loci.loci_backend.core.discovery.domain.aggregate.ContactProfileList;
import com.loci.loci_backend.core.discovery.domain.aggregate.Friend;
import com.loci.loci_backend.core.discovery.domain.aggregate.FriendList;
import com.loci.loci_backend.core.discovery.domain.vo.SearchQuery;
import com.loci.loci_backend.core.social.domain.repository.ContactRepository;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

@DomainService
@RequiredArgsConstructor
public class SearchEngine {
  private final ContactRepository contactRepository;
  private final UserRepository userRepository;
  private final CurrentUser principal;

  public ContactProfileList searchContact() {
    return null;
  }

  public FriendList searchFriend(SearchQuery query) {

    User user = userRepository.getByUsername(principal.getUsername()).orElseThrow(EntityNotFoundException::new);
    List<Friend> friends = contactRepository.findConnectedWithUser(query, user.getDbId());
    return new FriendList(friends);

  }

  void searchMessage() {
  }

}
