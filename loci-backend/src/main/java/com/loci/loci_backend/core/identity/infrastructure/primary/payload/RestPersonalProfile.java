package com.loci.loci_backend.core.identity.infrastructure.primary.payload;

import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RestPersonalProfile {
  private UUID userId;
  private String emailAddress;
  private String firstname;
  private String lastname;
  private String username;
  private String profilePictureUrl;
}
