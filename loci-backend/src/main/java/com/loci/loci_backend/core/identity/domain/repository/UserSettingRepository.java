package com.loci.loci_backend.core.identity.domain.repository;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.core.identity.domain.aggregate.UserSetting;

public interface UserSettingRepository {

  UserSetting save(UserSetting settings);
  UserSetting createSetting(User user, UserSetting setting);

}
