package com.loci.loci_backend.core.identity.domain.aggregate;

import java.time.Instant;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.vo.UserEmail;
import com.loci.loci_backend.common.user.domain.vo.UserImageUrl;
import com.loci.loci_backend.common.user.domain.vo.UserPublicId;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// @Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class PublicProfile {
  private UserPublicId publicId;
  private UserEmail email;
  private Fullname fullname;
  private Username username;
  private UserImageUrl imageUrl;
  private Instant createdDate;
}
