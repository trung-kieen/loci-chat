package com.loci.loci_backend.core.conversation.domain.aggregate;

import java.util.Set;

import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.common.validation.domain.Assert;
import com.loci.loci_backend.common.validation.domain.Validatable;
import com.loci.loci_backend.core.groups.domain.vo.GroupImageUrl;
import com.loci.loci_backend.core.groups.domain.vo.GroupName;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CreateGroupRequest implements Validatable {

  private GroupName groupName;
  private GroupImageUrl profileImage;
  private Set<PublicId> memberIds;

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

  @Override
  public void validate() {
    Assert.field("Member list", memberIds).minSize(2);
  }
}
