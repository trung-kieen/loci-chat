package com.loci.loci_backend.core.conversation.infrastructure.secondary.mapper;

import com.loci.loci_backend.common.mapper.ValueObjectTypeConverter;
import com.loci.loci_backend.core.conversation.domain.aggregate.Participant;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationParticipantEntity;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = {ValueObjectTypeConverter.class})
public interface MapStructParticipantEntityMapper {


  @Mapping(source = "createdDate", target = "joinedAt")
  public Participant toDomain(ConversationParticipantEntity entity) ;

  public ConversationParticipantEntity from(Participant domainObject);

}
