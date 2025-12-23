package com.loci.loci_backend.core.conversation.infrastructure.secondary.mapper;

import com.loci.loci_backend.common.mapper.ValueObjectTypeConverter;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationEntity;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = {ValueObjectTypeConverter.class})
public interface MapStructConversationEntityMapper {

  @Mapping(target = "messages", ignore = true)
  @Mapping(target = "participants", ignore = true)
  public Conversation toDomain(ConversationEntity entity);

  @Mapping(target = "creator", ignore = true)
  public ConversationEntity from(Conversation domainObject);
}
