package com.loci.loci_backend.core.social.application;

import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequest;
import com.loci.loci_backend.core.social.domain.service.FriendManager;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SocialApplicationService {
  private final FriendManager friendManager;

  public ContactRequest addContactRequest(CreateContactRequest contactRequest) {
    return friendManager.addFriendRequest(contactRequest);

  }

}
