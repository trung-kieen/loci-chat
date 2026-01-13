package com.loci.loci_backend.common.user.domain.repository;

import java.util.Collection;
import java.util.Set;

import com.loci.loci_backend.common.user.domain.aggregate.Authority;
import com.loci.loci_backend.common.user.domain.aggregate.User;

public interface AuthorityRepository {

  public Authority save(Authority authority);

  public boolean exists(Authority authority);

  public Set<Authority> createIfNotExists(Collection<Authority> authorities);

  public void addUserAuthorities(User user, Set<Authority> authorities);

}
