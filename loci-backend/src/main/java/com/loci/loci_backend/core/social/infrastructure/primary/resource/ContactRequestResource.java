package com.loci.loci_backend.core.social.infrastructure.primary.resource;

import java.util.UUID;

import com.loci.loci_backend.common.migration.domain.aggregate.KeycloakUser;
import com.loci.loci_backend.core.social.application.SocialApplicationService;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequest;
import com.loci.loci_backend.core.social.infrastructure.primary.mapper.RestContactMapper;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestFriendRequestResponse;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/contacts/")
@RequiredArgsConstructor
class ContactRequestResource {

  private final SocialApplicationService socialApplicationService;
  private final RestContactMapper contactMapper;

  @PostMapping("{userId}/request")
  @ResponseStatus(HttpStatus.CREATED)
  public RestFriendRequestResponse sendRequest(@PathVariable("userId") UUID receiverPublicId,
      KeycloakUser sender) {

    CreateContactRequest contactRequest = contactMapper.toDomain(receiverPublicId, sender);
    ContactRequest savedRequest = socialApplicationService.addContactRequest(contactRequest);

    return contactMapper.from(receiverPublicId, savedRequest);
  }


  // @PostMapping("/request")
  // @ResponseStatus(HttpStatus.CREATED)
  // public RestFriendRequestResponse getAllRequest(@PathVariable("userId") UUID receiverPublicId,
  //     KeycloakUser sender) {
  //
  //   CreateContactRequest contactRequest = contactMapper.toDomain(receiverPublicId, sender);
  //   ContactRequest savedRequest = socialApplicationService.addContactRequest(contactRequest);
  //
  //   return contactMapper.from(receiverPublicId, savedRequest);
  // }

}
