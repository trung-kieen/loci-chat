package com.loci.loci_backend.core.groups.domain.vo;

import com.loci.loci_backend.common.ddd.domain.contract.ValueObject;
import com.loci.loci_backend.common.validation.domain.Assert;

public record GroupName(String value) implements ValueObject<String> {

  public GroupName {
    Assert.field("group name", value).notBlank().minLength(3).maxLength(200);
  }

}
