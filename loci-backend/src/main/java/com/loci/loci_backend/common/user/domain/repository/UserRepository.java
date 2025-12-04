package com.loci.loci_backend.common.user.domain.repository;

import java.util.Optional;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.vo.UserEmail;
import com.loci.loci_backend.common.user.domain.vo.PublicId;

public interface UserRepository {

  Optional<User> getByPublicId(PublicId publicId);


  Optional<User> getByUsername(Username username);

  boolean existByEmail(UserEmail email);

  void save(User user);

}
