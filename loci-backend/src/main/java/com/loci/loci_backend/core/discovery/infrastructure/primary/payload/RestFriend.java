package com.loci.loci_backend.core.discovery.infrastructure.primary.payload;

import java.util.UUID;

import com.loci.loci_backend.core.social.infrastructure.secondary.enumernation.FriendshipStatusEnum;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RestFriend {

  private UUID userId;
  private String fullname;
  private String username;
  private String email;
  private String imageUrl;
  private FriendshipStatusEnum friendshipStatus = FriendshipStatusEnum.CONNECTED;

}
