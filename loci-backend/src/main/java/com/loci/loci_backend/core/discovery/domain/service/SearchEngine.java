package com.loci.loci_backend.core.discovery.domain.service;

import com.loci.loci_backend.common.authentication.domain.CurrentUser;
import com.loci.loci_backend.common.ddd.infrastructure.stereotype.DomainService;
import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.repository.UserRepository;
import com.loci.loci_backend.core.discovery.domain.aggregate.ContactProfileList;
import com.loci.loci_backend.core.discovery.domain.aggregate.Friend;
import com.loci.loci_backend.core.discovery.domain.aggregate.FriendList;
import com.loci.loci_backend.core.discovery.domain.vo.SearchQuery;
import com.loci.loci_backend.core.social.domain.repository.ContactRepository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

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

  public FriendList searchFriends(SearchQuery query, Pageable pageable) {

    User user = userRepository.getByUsername(principal.getUsername()).orElseThrow(EntityNotFoundException::new);
    Page<Friend> friends = contactRepository.findConnectedToUser(query, user.getDbId(), pageable);
    return new FriendList(friends);

  }

  void searchMessage() {
  }

}
