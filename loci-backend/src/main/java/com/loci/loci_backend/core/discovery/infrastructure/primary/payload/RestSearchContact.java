package com.loci.loci_backend.core.discovery.infrastructure.primary.payload;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

import lombok.Data;

@Data
public class RestSearchContact {
  private String fullname;
  private String username;
  private String userEmail;
  private String imageUrl;
  private String friendshipStatus;

  @Builder(style = BuilderStyle.STAGED)
  public RestSearchContact(String fullname, String username, String userEmail, String imageUrl,
      String friendshipStatus) {
    this.fullname = fullname;
    this.username = username;
    this.userEmail = userEmail;
    this.imageUrl = imageUrl;
    this.friendshipStatus = friendshipStatus;
  }
}
