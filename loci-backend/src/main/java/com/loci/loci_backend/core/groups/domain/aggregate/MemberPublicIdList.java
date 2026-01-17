package com.loci.loci_backend.core.groups.domain.aggregate;

import java.util.Set;

import com.loci.loci_backend.common.ddd.domain.contract.ValueObject;
import com.loci.loci_backend.common.user.domain.vo.PublicId;

public record MemberPublicIdList(Set<PublicId> ids) implements ValueObject<Set<PublicId>> {

  @Override
  public Set<PublicId> value() {
    return ids;
  }
}
