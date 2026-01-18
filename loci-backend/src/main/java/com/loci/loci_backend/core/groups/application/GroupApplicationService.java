package com.loci.loci_backend.core.groups.application;

import com.loci.loci_backend.common.ddd.infrastructure.stereotype.ApplicationService;
import com.loci.loci_backend.common.store.domain.aggregate.File;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.groups.domain.aggregate.CreateGroupProfileRequest;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfileChanges;
import com.loci.loci_backend.core.groups.domain.service.GroupManager;

import lombok.RequiredArgsConstructor;

@ApplicationService
@RequiredArgsConstructor
public class GroupApplicationService {

  private final GroupManager groupManager;

  public GroupProfile createGroupProfile(CreateGroupProfileRequest createProfileRequest) {
    return groupManager.createGroupProfile(createProfileRequest);
  }

  public GroupProfile retrieveGroupInfo(PublicId groupPublicId) {
    return groupManager.retrieveGroupInfo(groupPublicId);
  }

  public GroupProfile updatGroupInfo(PublicId groupPublicId, GroupProfileChanges profileChanges) {
    return groupManager.updatGroupInfo(groupPublicId, profileChanges);
  }

  public GroupProfile updateProfileAvatar(PublicId groupPublicId, File file) {
    return groupManager.applyGroupUpdateImage(groupPublicId, file);
  }

}
