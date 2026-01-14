package com.loci.loci_backend.core.conversation.domain.aggregate;

import java.util.List;
import java.util.UUID;

import com.loci.loci_backend.core.groups.domain.vo.GroupImageUrl;
import com.loci.loci_backend.core.groups.domain.vo.GroupName;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CreateGroupRequest {

  private GroupName groupName;
  private GroupImageUrl profileImage;
  // TODO: add list of memberIds
  private List<UUID> memberIds;

  @Builder(style = BuilderStyle.STAGED)
  public CreateGroupRequest(GroupName groupName, GroupImageUrl profileImage) {
    this.groupName = groupName;
    this.profileImage = profileImage;
  }

  public void provideMandatoryField() {
    initGroupImageForSignUp();
  }

  private void initGroupImageForSignUp() {
    if (this.profileImage == null || profileImage.value() == null) {
      this.profileImage = GroupImageUrl.random();
    }
  }
}
