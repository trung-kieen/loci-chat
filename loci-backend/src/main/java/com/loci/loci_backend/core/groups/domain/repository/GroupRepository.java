package com.loci.loci_backend.core.groups.domain.repository;

import java.util.Optional;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.conversation.domain.vo.ConversationId;
import com.loci.loci_backend.core.groups.domain.aggregate.CreateGroupProfileRequest;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfileChanges;

public interface GroupRepository {

  Optional<GroupProfile> getByConversationId(ConversationId conversationId);

  GroupProfile createProfile(CreateGroupProfileRequest request);

  public Optional<GroupProfile> getByPublicId(PublicId publicId);

  GroupProfile applyProfileUpdate(PublicId groupPublicId, GroupProfileChanges profileChanges);
}
