package com.loci.loci_backend.core.identity.domain.service;

import com.loci.loci_backend.core.identity.domain.aggregate.PersonalProfile;
import com.loci.loci_backend.core.identity.domain.aggregate.PersonalProfileChanges;
import com.loci.loci_backend.core.identity.domain.aggregate.ProfileSettingChanges;
import com.loci.loci_backend.core.identity.domain.aggregate.UserSetting;

public interface ProfileAggregateMapper {
  public PersonalProfileChanges extractChanges(PersonalProfile currentProfile);
  public void applyChanges(PersonalProfile profile, PersonalProfileChanges changes);
  public void applyChanges(UserSetting settings , ProfileSettingChanges  changes );
}
