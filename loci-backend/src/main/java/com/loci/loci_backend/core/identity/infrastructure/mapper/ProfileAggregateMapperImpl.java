package com.loci.loci_backend.core.identity.infrastructure.mapper;

import com.loci.loci_backend.core.identity.domain.aggregate.PersonalProfile;
import com.loci.loci_backend.core.identity.domain.aggregate.PersonalProfileChanges;
import com.loci.loci_backend.core.identity.domain.aggregate.PersonalProfileChangesBuilder;
import com.loci.loci_backend.core.identity.domain.aggregate.PrivacySetting;
import com.loci.loci_backend.core.identity.domain.service.ProfileAggregateMapper;

import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ProfileAggregateMapperImpl implements ProfileAggregateMapper {
  private final MapStructProfileMapper profileMapper;

  @Override
  public PersonalProfileChanges extractChanges(PersonalProfile currentProfile) {
    return PersonalProfileChangesBuilder.personalProfileChanges()
        .fullname(currentProfile.getFullname())
        .bio(currentProfile.getBio())
        .imageUrl(currentProfile.getImageUrl())
        .privacySetting(PrivacySetting.of(currentProfile.getPrivacySetting()))
        .build();
  }

  @Override
  public void applyChanges(PersonalProfile profile, PersonalProfileChanges changes) {
    profileMapper.applyProfileUpdate(profile, changes);
  }

}
