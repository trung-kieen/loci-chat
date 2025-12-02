package com.loci.loci_backend.core.identity.domain.vo;

import com.loci.loci_backend.common.util.NullSafe;
import com.loci.loci_backend.common.util.ValueObject;

public record UserFriendRequestSetting(FriendRequestSettingEnum value) implements ValueObject<FriendRequestSettingEnum>{
  public static UserFriendRequestSetting of(String value) {
    return NullSafe.getIfPresent(value,  v -> new UserFriendRequestSetting(FriendRequestSettingEnum.of(v)));
  }

  public static UserFriendRequestSetting ofDefault(){
    return new UserFriendRequestSetting(FriendRequestSettingEnum.of(null));
  }
  public static UserFriendRequestSetting ofEnum(FriendRequestSettingEnum value) {
    if (value == null) return UserFriendRequestSetting.ofDefault();
    return new UserFriendRequestSetting(value);
  }

  public static UserFriendRequestSetting of(UserFriendRequestSetting value) {
    if (value == null) return UserFriendRequestSetting.ofDefault();
    return value;
  }
}
