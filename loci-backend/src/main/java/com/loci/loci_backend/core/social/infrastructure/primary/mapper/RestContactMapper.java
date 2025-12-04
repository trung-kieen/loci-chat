package com.loci.loci_backend.core.social.infrastructure.primary.mapper;

import java.util.UUID;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.migration.domain.aggregate.KeycloakUser;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequest;
import com.loci.loci_backend.core.social.domain.aggregate.CreateContactRequestBuilder;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestFriendRequestResponse;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestFriendRequestResponseBuilder;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestContactMapper {

  public CreateContactRequest toDomain(UUID receiverPublicId, KeycloakUser sender) {
    Username senderUsername = sender.getUsername();
    return CreateContactRequestBuilder.createContactRequest()
        .sendUsername(senderUsername)
        .receiverPublicId(new PublicId(receiverPublicId))
        .build();
  }

  /**
   * Not leak internal system information
   */
  public RestFriendRequestResponse from(UUID receiverPublicId, ContactRequest savedRequest) {
    return RestFriendRequestResponseBuilder.restFriendRequestResponse()
        .contactRequestId(savedRequest.getId().value())
        .receiverPublicId(receiverPublicId)
        .build();
  }

}
