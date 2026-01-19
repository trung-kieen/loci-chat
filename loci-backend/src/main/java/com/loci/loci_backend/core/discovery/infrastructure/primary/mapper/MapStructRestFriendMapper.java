package com.loci.loci_backend.core.discovery.infrastructure.primary.mapper;

import com.loci.loci_backend.common.ddd.infrastructure.mapper.ValueObjectTypeConverter;
import com.loci.loci_backend.core.discovery.domain.aggregate.Friend;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestFriend;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = ValueObjectTypeConverter.class)
public interface MapStructRestFriendMapper {

  @Mapping(source = "publicId", target = "userId")
  @Mapping(target = "friendshipStatus", ignore = true)
  public RestFriend from(Friend entity);

}
