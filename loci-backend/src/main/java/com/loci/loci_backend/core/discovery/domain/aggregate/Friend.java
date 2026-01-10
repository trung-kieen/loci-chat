package com.loci.loci_backend.core.discovery.domain.aggregate;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.common.user.domain.vo.UserDBId;
import com.loci.loci_backend.common.user.domain.vo.UserEmail;
import com.loci.loci_backend.common.user.domain.vo.UserImageUrl;
import com.loci.loci_backend.core.identity.domain.aggregate.UserFullname;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Friend {
  private PublicId publicId;
  private UserDBId id;
  private UserFullname fullname;
  private Username username;
  private UserImageUrl imageUrl;
  private UserEmail email;

}
