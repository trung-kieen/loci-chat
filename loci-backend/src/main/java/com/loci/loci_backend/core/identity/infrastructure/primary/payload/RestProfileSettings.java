package com.loci.loci_backend.core.identity.infrastructure.primary.payload;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.loci.loci_backend.common.util.NullSafe;
import com.loci.loci_backend.core.identity.domain.aggregate.UserSetting;
import com.loci.loci_backend.core.identity.infrastructure.secondary.enumeration.FriendRequestSettingEnum;
import com.loci.loci_backend.core.identity.infrastructure.secondary.enumeration.LastSeenSettingEnum;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class RestProfileSettings {
  private LastSeenSettingEnum lastSeenSetting;
  private FriendRequestSettingEnum friendRequests;
  private boolean profileVisibility;

  @Builder
  public RestProfileSettings(LastSeenSettingEnum lastSeenSetting, FriendRequestSettingEnum friendRequests,
      boolean profileVisibility) {
    this.lastSeenSetting = lastSeenSetting;
    this.friendRequests = friendRequests;
    this.profileVisibility = profileVisibility;
  }

  public static RestProfileSettings from(UserSetting settings) {
    return RestProfileSettings.builder()
        .profileVisibility(settings.getProfileVisibility().value())
        .friendRequests(settings.getFriendRequestSetting().value())
        .lastSeenSetting(settings.getLastSeenSetting().value())
        .build();
  }

  public static RestProfileSettings of(UserSetting settings) {
    return RestProfileSettings.builder()
        .profileVisibility(NullSafe.getIfPresent(settings.getProfileVisibility(), (s) -> s.value()))
        .friendRequests(NullSafe.getIfPresent(settings.getFriendRequestSetting(), (s) -> s.value()))
        .lastSeenSetting(NullSafe.getIfPresent(settings.getLastSeenSetting(), (s) -> s.value()))
        .build();
  }

  // public static UserSettings toDomain(RestProfileSettings partialUpdateRequest)
  // {
  // return UserSettingsBuilder.userSettings()
  // .profileVisibility(ProfileVisibility.of(partialUpdateRequest.profileVisibility))
  // .friendRequestSetting(partialUpdateRequest.friendRequests)
  // .lastSeenSetting(partialUpdateRequest.lastSeenSetting)
  // .build();
  // }

}
