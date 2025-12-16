package com.loci.loci_backend.core.identity.domain.repository;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.core.identity.domain.aggregate.UserSettings;

public interface UserSettingsRepository {

  UserSettings save(UserSettings settings);
  UserSettings createSettings(User user, UserSettings settings);

}
