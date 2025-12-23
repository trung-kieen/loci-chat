package com.loci.loci_backend.core.conversation.domain.vo;

public enum ConversationType {
  ONE_TO_ONE("one to one"),
  GROUP("group");

  private String value;

  private ConversationType(String value) {
    this.value = value;
  }

}
