package com.loci.loci_backend.core.discovery.infrastructure.secondary.mapper;

import com.loci.loci_backend.common.ddd.infrastructure.stereotype.SecondaryMapper;
import com.loci.loci_backend.common.user.infrastructure.secondary.entity.UserEntity;
import com.loci.loci_backend.core.discovery.domain.aggregate.ContactProfile;
import com.loci.loci_backend.core.social.domain.vo.FriendshipStatus;

import org.springframework.data.domain.Page;

import lombok.RequiredArgsConstructor;

@SecondaryMapper
@RequiredArgsConstructor
public class ContactProfileEntityMapper {
  private final MapStructContactProfileEntityMapper mapstruct;

  public Page<ContactProfile> toDomain(Page<UserEntity> entityPage) {
    return entityPage.map(this::toDomain);
  }

  public ContactProfile toDomain(UserEntity entity, FriendshipStatus friendshipStatus) {
    return mapstruct.toDomain(entity, friendshipStatus);
  }

  public ContactProfile toDomain(UserEntity entity) {
    return toDomain(entity, FriendshipStatus.ofDefault());
  }

}
