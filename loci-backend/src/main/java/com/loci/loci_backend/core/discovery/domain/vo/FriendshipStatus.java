package com.loci.loci_backend.core.discovery.domain.vo;

import com.loci.loci_backend.common.util.ValueObject;

public enum FriendshipStatus implements ValueObject<String> {
  NOT_CONNECTED("not_connected"),
  PENDING_REQUEST("friend_request_sent"),
  CONNECTED("friends"),
  UNKNOWN("not_determined"),
  REQUEST_RECEIVED("friend_request_received"),
  BLOCKED("blocked"),
  BLOCKED_BY_THEM("blocked_by");

  private String value;

  private FriendshipStatus(String value) {
    this.value = value;
  }

  @Override
  public String value() {
    return this.value;
  }
}
