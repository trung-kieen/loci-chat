package com.loci.loci_backend.core.social.infrastructure.primary.mapper;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.migration.domain.aggregate.KeycloakUser;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequestBuilder;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestFriendRequestResponse;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestFriendRequestResponseBuilder;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestSendContactRequest;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestContactMapper {

  public CreateContactRequest toDomain(RestSendContactRequest request, KeycloakUser sender) {
    Username senderUsername = sender.getUsername();
    return CreateContactRequestBuilder.createContactRequest()
        .sendUsername(senderUsername)
        .receiverPublicId(new PublicId(request.getReceiverPublicId()))
        .build();
  }

  /**
   * Not leak internal system information
   */
  public RestFriendRequestResponse from(RestSendContactRequest request, ContactRequest savedRequest) {
    return RestFriendRequestResponseBuilder.restFriendRequestResponse()
        .contactRequestId(savedRequest.getId().value())
        .receiverPublicId(request.getReceiverPublicId())
        .build();
  }

}
