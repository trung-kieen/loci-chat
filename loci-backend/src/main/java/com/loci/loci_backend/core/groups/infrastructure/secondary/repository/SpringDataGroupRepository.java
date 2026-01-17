package com.loci.loci_backend.core.groups.infrastructure.secondary.repository;

import java.util.Optional;

import com.loci.loci_backend.common.ddd.infrastructure.stereotype.SecondaryPort;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.conversation.domain.vo.ConversationId;
import com.loci.loci_backend.core.groups.domain.aggregate.CreateGroupProfileRequest;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfileChanges;
import com.loci.loci_backend.core.groups.domain.repository.GroupRepository;
import com.loci.loci_backend.core.groups.infrastructure.secondary.entity.GroupEntity;
import com.loci.loci_backend.core.groups.infrastructure.secondary.mapper.GroupEntityMapper;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

@SecondaryPort
@RequiredArgsConstructor
public class SpringDataGroupRepository implements GroupRepository {

  private final JpaGroupRepository repository;
  private final GroupEntityMapper mapper;

  @Override
  public Optional<GroupProfile> getByConversationId(ConversationId conversationId) {
    return repository.findByConversationId(conversationId.value()).map(mapper::toDomain);
  }

  @Override
  public GroupProfile createProfile(CreateGroupProfileRequest request) {
    GroupEntity entity = mapper.from(request);
    GroupEntity savedProfile = repository.save(entity);
    return mapper.toDomain(savedProfile);
  }

  @Override
  public Optional<GroupProfile> getByPublicId(PublicId publicId) {
    return repository.findByPublicId(publicId.value()).map(mapper::toDomain);
  }

  @Override
  public GroupProfile applyProfileUpdate(PublicId groupPublicId, GroupProfileChanges profileChanges) {
    GroupEntity groupEntity = repository.findByPublicId(groupPublicId.value())
        .orElseThrow(EntityNotFoundException::new);
    groupEntity.applyChanges(profileChanges);
    GroupEntity savedEntity = repository.save(groupEntity);

    return mapper.toDomain(savedEntity);

  }

}
