package com.loci.loci_backend.core.social.infrastructure.primary.resource;

import com.loci.loci_backend.common.migration.domain.aggregate.KeycloakUser;
import com.loci.loci_backend.core.social.application.SocialApplicationService;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequest;
import com.loci.loci_backend.core.social.infrastructure.primary.mapper.RestContactMapper;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestFriendRequestResponse;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestSendContactRequest;

import org.apache.commons.lang3.NotImplementedException;
import org.eclipse.microprofile.openapi.annotations.parameters.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/contacts")
@RequiredArgsConstructor
class ContactRequestResource {

  private final SocialApplicationService socialApplicationService;
  private final RestContactMapper contactMapper;

  @PostMapping("request")
  @ResponseStatus(HttpStatus.CREATED)
  public RestFriendRequestResponse sendRequest(@Valid @RequestBody RestSendContactRequest request,
      KeycloakUser sender) {

    CreateContactRequest contactRequest = contactMapper.toDomain(request, sender);
    ContactRequest savedRequest = socialApplicationService.addContactRequest(contactRequest);

    return contactMapper.from(request, savedRequest);
  }
}
