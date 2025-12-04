package com.loci.loci_backend.core.social.domain.service;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.repository.UserRepository;
import com.loci.loci_backend.common.validation.domain.DuplicateResourceException;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequest;
import com.loci.loci_backend.core.social.domain.repository.ContactRepository;
import com.loci.loci_backend.core.social.domain.repository.ContactRequestRepository;
import com.nimbusds.jose.JWEObjectJSON.Recipient;

import org.apache.coyote.BadRequestException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FriendManager {
  private final UserRepository userRepository;
  private final ContactRepository contactRepository;
  private final ContactRequestRepository contactRequestRepository;

  @Transactional(readOnly = false)
  public ContactRequest addFriendRequest(CreateContactRequest request) {
    User sender = userRepository.getByUsername(request.getSenderUsername())
        .orElseThrow(() -> new EntityNotFoundException("Not found sender information"));
    User receiver = userRepository.getByPublicId(request.getReceiverPublicId())
        .orElseThrow(() -> new EntityNotFoundException("Not found target contact information"));

    // Not allow to request to friend
    if (contactRepository.existsContactConnection(sender, receiver)) {
      throw new DuplicateResourceException("Already friend", "friend conntection");
    }

    if (sender.equals(receiver)) {
      // TODO: create Bad_request type for this error
      throw new IllegalArgumentException("Unable to send request to yourself");
    }

    // Not allow to duplicate the request
    if (contactRequestRepository.existsPendingRequest(sender, receiver)) {
      throw new DuplicateResourceException("Request already sent", "friend request");
    }

    ContactRequest contactRequest = ContactRequest.builderRequest(sender, receiver);
    contactRequest.assertManadatoryField();

    ContactRequest savedRequest = contactRequestRepository.save(contactRequest);
    return savedRequest;

  }

  // void unFriend();
  //
  // void acceptFriendRequest();
  //
  // void rejectFriendRequest();
  //
  // void viewListContactRequest();

}
