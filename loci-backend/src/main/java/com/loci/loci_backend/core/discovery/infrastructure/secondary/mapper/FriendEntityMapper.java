package com.loci.loci_backend.core.discovery.infrastructure.secondary.mapper;

import java.util.List;

import com.loci.loci_backend.common.ddd.infrastructure.stereotype.SecondaryMapper;
import com.loci.loci_backend.common.user.infrastructure.secondary.entity.UserEntity;
import com.loci.loci_backend.core.discovery.domain.aggregate.Friend;

import lombok.RequiredArgsConstructor;

@SecondaryMapper
@RequiredArgsConstructor
public class FriendEntityMapper {
  private final MapStructFriendEntityMapper mapstruct;

  public Friend toDomain(UserEntity entity) {
    return mapstruct.toDomain(entity);
  }

  public List<Friend> toDomain(List<UserEntity> entities) {
    return entities.stream().map(this::toDomain).toList();

  }
}
