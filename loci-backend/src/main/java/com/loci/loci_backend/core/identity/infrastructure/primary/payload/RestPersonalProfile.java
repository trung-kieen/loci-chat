package com.loci.loci_backend.core.identity.infrastructure.primary.payload;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RestPersonalProfile {
  private String emailAddress;
  private String firstname;
  private String lastname;
  private String username;
  private String profilePictureUrl;
  private RestProfilePrivacy privacy;

}
