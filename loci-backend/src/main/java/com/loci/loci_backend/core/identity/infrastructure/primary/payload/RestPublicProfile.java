package com.loci.loci_backend.core.identity.infrastructure.primary.payload;

import java.time.Instant;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RestPublicProfile {

  private String publicId;
  private String username;
  private String fullname;
  private String emailAddress;
  private String memberSince;
  private Instant createdAt;
  private String profilePictureUrl;

  // TODO: Implement other profile details
  // lastActive: Date;
  // mutualFriendCount: number;
  // connectionStatus: ConnectionStatus;
  // showEmail: boolean;
  // showLastOnline: boolean;
  // recentActivity: RecentActivity[];
  // unfriended, blocked, not_determined aka guest

}
