package com.loci.loci_backend.common.user.domain.aggregate;

import java.time.Instant;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.vo.AuthorityName;
import com.loci.loci_backend.common.user.domain.vo.UserEmail;
import com.loci.loci_backend.common.user.domain.vo.UserFirstname;
import com.loci.loci_backend.common.user.domain.vo.UserImageUrl;
import com.loci.loci_backend.common.user.domain.vo.UserLastname;
import com.loci.loci_backend.common.user.domain.vo.UserPublicId;
import com.loci.loci_backend.common.validation.domain.Assert;
import com.loci.loci_backend.core.identity.domain.aggregate.PrivacySetting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@AllArgsConstructor
@Data
public class User {

  private UserPublicId userPublicId;

  private Long dbId;

  private UserEmail email;

  private UserFirstname firstname;

  private UserLastname lastname;

  private Username username;

  private UserImageUrl profilePicture;

  private Instant createdDate;

  private Instant lastModifiedDate;

  private Instant lastActive;

  private PrivacySetting privacySetting;

  private Set<Authority> authorities;

  public void assertMandatoryFields() {
    Assert.notNull("email", email);
    Assert.notNull("lastname", lastname);
    Assert.notNull("firstname", firstname);
    Assert.notNull("username", username);
    Assert.notNull("authorities", authorities);
  }

  public void updateFromUser(User user) {
    if (user != null) {
      this.email = user.email;
      this.profilePicture = user.profilePicture;
      this.firstname = user.firstname;
      this.lastname = user.lastname;
      this.firstname = user.firstname;
      this.lastname = user.lastname;
      this.userPublicId = user.userPublicId;
    }
  }

  public void provideMandatoryField() {
    if (this.userPublicId == null) {
      this.initFieldForSignup();
    }

  }

  public void initFieldForSignup() {
    this.userPublicId = UserPublicId.random();
  }

  public static User fromTokenAttributes(Map<String, Object> attributes, Collection<String> rolesFromAccessToken) {

    UserBuilder userBuilder = User.builder();

    if (attributes.containsKey("email")) {
      userBuilder.email(new UserEmail(attributes.get("email").toString()));
    }

    if (attributes.containsKey("family_name")) {
      userBuilder.firstname(new UserFirstname(attributes.get("family_name").toString()));
    }

    if (attributes.containsKey("given_name")) {
      userBuilder.lastname(new UserLastname(attributes.get("given_name").toString()));
    }

    if (attributes.containsKey("picture")) {
      userBuilder.profilePicture(new UserImageUrl(attributes.get("picture").toString()));
    }


    if (attributes.containsKey("preferred_username")) {
      Username username = new Username(attributes.get("preferred_username").toString());
      userBuilder.username(username);
    }

    if (attributes.containsKey("last_signed_in")) {
      userBuilder.lastActive(
          Instant.parse(attributes.get("last_signed_in").toString()));
    } else {
      userBuilder.lastActive(Instant.now());
    }

    Set<Authority> authorities = rolesFromAccessToken.stream()
        .map(authority -> Authority.builder()
            .name(new AuthorityName(authority))
            .build())
        .collect(Collectors.toSet());

    userBuilder.authorities(authorities);

    return userBuilder.build();
  }

  public Username getUsername() {
    return username;
  }
}
