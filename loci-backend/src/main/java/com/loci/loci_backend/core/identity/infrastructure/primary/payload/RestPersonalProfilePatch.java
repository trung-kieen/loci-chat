package com.loci.loci_backend.core.identity.infrastructure.primary.payload;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
public class RestPersonalProfilePatch {
  private String firstname;
  private String lastname;

  // Unchange field
  // private String username;
  // private String emailAddress;

  private String profilePictureUrl;
  private RestProfilePrivacy privacy;


}
