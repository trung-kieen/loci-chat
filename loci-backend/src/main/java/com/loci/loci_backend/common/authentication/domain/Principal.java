package com.loci.loci_backend.common.authentication.domain;

import com.loci.loci_backend.common.user.domain.vo.UserEmail;

public interface Principal {
  Username getUsername();

  UserEmail getUserEmail();
}
