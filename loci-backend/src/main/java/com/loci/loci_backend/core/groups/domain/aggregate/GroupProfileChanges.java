package com.loci.loci_backend.core.groups.domain.aggregate;

import com.loci.loci_backend.core.groups.domain.vo.GroupImageUrl;
import com.loci.loci_backend.core.groups.domain.vo.GroupName;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class GroupProfileChanges {

  private GroupName groupName;

  private GroupImageUrl groupProfilePicture;

}
