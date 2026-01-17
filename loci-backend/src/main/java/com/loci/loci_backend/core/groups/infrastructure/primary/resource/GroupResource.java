package com.loci.loci_backend.core.groups.infrastructure.primary.resource;

import org.springframework.web.bind.annotation.RequestBody;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.groups.application.GroupApplicationService;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfile;
import com.loci.loci_backend.core.groups.domain.aggregate.GroupProfileChanges;
import com.loci.loci_backend.core.groups.infrastructure.primary.mapper.RestGroupMapper;
import com.loci.loci_backend.core.groups.infrastructure.primary.payload.RestGroupProfile;
import com.loci.loci_backend.core.groups.infrastructure.primary.payload.RestGroupProfileChanges;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("groups")
public class GroupResource {
  private final GroupApplicationService groupApplicationService;
  private final RestGroupMapper groupMapper;

  @GetMapping("/{groupId}")
  public ResponseEntity<RestGroupProfile> getProfile(@PathVariable("groupId") PublicId groupPublicId) {
    GroupProfile group = groupApplicationService.retrieveGroupInfo(groupPublicId);
    return ResponseEntity.ok(groupMapper.from(group));
  }

  @PatchMapping("/{groupId}")
  public ResponseEntity<RestGroupProfile> partialUpdateProfile(@PathVariable("groupId") PublicId groupPublicId,
      @RequestBody RestGroupProfileChanges restGroupProfileChanges) {
    GroupProfileChanges changes = groupMapper.toDomain(restGroupProfileChanges);
    GroupProfile updatedProfile = groupApplicationService.updatGroupInfo(groupPublicId, changes);
    return ResponseEntity.ok(groupMapper.from(updatedProfile));
  }
}
