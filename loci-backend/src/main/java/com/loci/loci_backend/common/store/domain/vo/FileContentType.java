package com.loci.loci_backend.common.store.domain.vo;

import com.loci.loci_backend.common.util.ValueObject;

public record FileContentType(String contentType) implements ValueObject<String> {

  @Override
  public String value() {
    return this.contentType();
  }
}
