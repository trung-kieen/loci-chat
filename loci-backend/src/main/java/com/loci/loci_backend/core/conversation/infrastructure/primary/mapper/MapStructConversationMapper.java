package com.loci.loci_backend.core.conversation.infrastructure.primary.mapper;

import com.loci.loci_backend.common.mapper.ValueObjectTypeConverter;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.CreateGroupRequest;
import com.loci.loci_backend.core.conversation.infrastructure.primary.payload.RestConversation;
import com.loci.loci_backend.core.conversation.infrastructure.primary.payload.RestCreateGroup;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = { ValueObjectTypeConverter.class })
public interface MapStructConversationMapper {

  @Mapping(source = "publicId", target = "id")
  public RestConversation from(Conversation domain);

  public CreateGroupRequest from(RestCreateGroup rest);

}
