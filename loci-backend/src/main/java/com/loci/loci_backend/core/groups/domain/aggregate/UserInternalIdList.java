package com.loci.loci_backend.core.groups.domain.aggregate;

import java.util.Set;

import com.loci.loci_backend.common.ddd.domain.contract.ValueObject;
import com.loci.loci_backend.common.user.domain.vo.UserDBId;

public record UserInternalIdList(Set<UserDBId> ids) implements ValueObject<Set<UserDBId>> {

  @Override
  public Set<UserDBId> value() {
    return ids;
  }
}
