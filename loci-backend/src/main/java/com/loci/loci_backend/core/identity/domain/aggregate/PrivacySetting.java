package com.loci.loci_backend.core.identity.domain.aggregate;

import com.loci.loci_backend.core.identity.domain.vo.ProfileVisibility;
import com.loci.loci_backend.core.identity.domain.vo.UserFriendRequestSetting;
import com.loci.loci_backend.core.identity.domain.vo.UserLastSeenSetting;

import org.jilt.Builder;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PrivacySetting {
  private UserLastSeenSetting lastSeenSetting;
  private UserFriendRequestSetting friendRequestSetting;
  private ProfileVisibility profileVisibility;

  @Builder
  public PrivacySetting(UserLastSeenSetting lastSeenSetting, UserFriendRequestSetting friendRequestSetting,

      ProfileVisibility profileVisibility) {
    this.lastSeenSetting = lastSeenSetting;
    this.friendRequestSetting = friendRequestSetting;
    this.profileVisibility = profileVisibility;
  }

  public static PrivacySetting of(PrivacySetting settings) {
    if (settings == null) {
      return PrivacySetting.ofDefault();
    }
    return PrivacySettingBuilder.privacySetting()
        .lastSeenSetting(UserLastSeenSetting.of(settings.getLastSeenSetting()))
        .friendRequestSetting(UserFriendRequestSetting.of(settings.getFriendRequestSetting()))
        .profileVisibility(ProfileVisibility.of(settings.getProfileVisibility()))
        .build();
  }

  public static PrivacySetting ofDefault() {
    return PrivacySettingBuilder.privacySetting()
        .lastSeenSetting(UserLastSeenSetting.ofDefault())
        .friendRequestSetting(UserFriendRequestSetting.ofDefault())
        .profileVisibility(ProfileVisibility.ofDefault())
        .build();
  }

}
