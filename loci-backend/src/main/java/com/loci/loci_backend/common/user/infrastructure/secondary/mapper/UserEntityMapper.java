package com.loci.loci_backend.common.user.infrastructure.secondary.mapper;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.vo.UserEmail;
import com.loci.loci_backend.common.user.domain.vo.UserFirstname;
import com.loci.loci_backend.common.user.domain.vo.UserImageUrl;
import com.loci.loci_backend.common.user.domain.vo.UserLastname;
import com.loci.loci_backend.common.user.domain.vo.UserPublicId;
import com.loci.loci_backend.common.user.infrastructure.secondary.entity.UserEntity;
import com.loci.loci_backend.common.user.infrastructure.secondary.entity.UserEntity.UserEntityBuilder;
import com.loci.loci_backend.common.util.NullSafe;
import com.loci.loci_backend.core.identity.domain.aggregate.Fullname;
import com.loci.loci_backend.core.identity.domain.aggregate.PersonalProfile;
import com.loci.loci_backend.core.identity.domain.aggregate.PublicProfile;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class UserEntityMapper {
  private final AuthorityEntityMapper authorityEntityMapper;

  public PublicProfile toPublicProfile(UserEntity userEntity) {
    return PublicProfile.builder()
        .publicId(new UserPublicId(userEntity.getPublicId()))
        .email(new UserEmail(userEntity.getEmail()))
        .fullname(
            Fullname.from(new UserFirstname(userEntity.getFirstname()), new UserLastname(userEntity.getLastname())))
        .username(new Username(userEntity.getUsername()))
        .imageUrl(new UserImageUrl(userEntity.getProfilePicture()))
        .createdDate(userEntity.getCreatedDate())
        .build();
  }

  public Page<PublicProfile> toDomain(Page<UserEntity> userPage) {
    Page<PublicProfile> profilePage = userPage.map(this::toPublicProfile);

    return profilePage;

  }

  public User toDomain(UserEntity userEntity) {
    return User.builder()
        .dbId(userEntity.getId())
        .userPublicId(new UserPublicId(userEntity.getPublicId()))
        .email(new UserEmail(userEntity.getEmail()))
        .username(new Username(userEntity.getUsername()))
        .firstname(new UserFirstname(userEntity.getFirstname()))
        .lastname(new UserLastname(userEntity.getLastname()))
        .profilePicture(new UserImageUrl(userEntity.getProfilePicture()))
        .createdDate(userEntity.getCreatedDate())
        .lastModifiedDate(userEntity.getLastModifiedDate())
        .lastActive(userEntity.getLastActive())
        .privacySetting(userEntity.getPrivacySetting())
        .authorities(authorityEntityMapper.toDomain(userEntity.getAuthorities()))
        .build();
  }

  public PersonalProfile toPersonalProfile(UserEntity userEntity) {
    return PersonalProfile.builder()
        .fullname(
            Fullname.from(new UserFirstname(userEntity.getFirstname()), new UserLastname(userEntity.getLastname())))
        .email(new UserEmail(userEntity.getEmail()))
        .username(new Username(userEntity.getUsername()))
        .userPublicId(new UserPublicId(userEntity.getPublicId()))
        .imageUrl(new UserImageUrl(userEntity.getProfilePicture()))
        .lastModifiedDate(userEntity.getLastModifiedDate())
        .createdDate(userEntity.getCreatedDate())
        .authorities(authorityEntityMapper.toDomain(userEntity.getAuthorities()))
        .privacySetting(userEntity.getPrivacySetting())
        .dbId(userEntity.getId())
        .build();
  }

  public UserEntity from(PersonalProfile profile) {
    UserEntityBuilder userEntityBuilder = UserEntity.builder();


    return userEntityBuilder
        .id(profile.getDbId())
        .publicId(NullSafe.getIfPresent(profile.getUserPublicId()))
        .email(profile.getEmail().value())
        .username(profile.getUsername().value())
        .firstname(profile.getFullname().getFirstname().value())
        .lastname(profile.getFullname().getLastname().value())
        .profilePicture(NullSafe.getIfPresent(profile.getImageUrl()))
        .lastActive(profile.getLastActive())
        .lastSeenSetting(profile.getPrivacySetting().getLastSeenSetting().value())
        .friendRequestSetting(profile.getPrivacySetting().getFriendRequestSetting().value())
        .profileVisibility(profile.getPrivacySetting().getProfileVisibility().value())
        .authorities(authorityEntityMapper.from(profile.getAuthorities()))
        .build();
  }

  public UserEntity from(User user) {
    UserEntity.UserEntityBuilder builder = UserEntity.builder()
        .id(user.getDbId())
        .publicId(NullSafe.getIfPresent(user.getUserPublicId()))
        .email(user.getEmail().value())
        .firstname(user.getFirstname().value())
        .lastname(user.getLastname().value())
        .username(user.getUsername().value())
        .profilePicture(NullSafe.getIfPresent(user.getProfilePicture()))
        .lastActive(user.getLastActive())
        .authorities(authorityEntityMapper.from(user.getAuthorities()));
    NullSafe.applyIfPresent(user::getPrivacySetting, ps -> {
      NullSafe.applyIfPresent(ps::getLastSeenSetting, lss -> builder.lastSeenSetting(lss.value()));
      NullSafe.applyIfPresent(ps::getFriendRequestSetting, frs -> builder.friendRequestSetting(frs.value()));
      NullSafe.applyIfPresent(ps::getProfileVisibility, pv -> builder.profileVisibility(pv.value()));
    });

    return builder.build();
  }

}
