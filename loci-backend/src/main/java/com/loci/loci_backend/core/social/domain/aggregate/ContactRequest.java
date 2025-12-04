package com.loci.loci_backend.core.social.domain.aggregate;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.vo.UserDBId;
import com.loci.loci_backend.common.validation.domain.Assert;
import com.loci.loci_backend.core.social.domain.vo.ContactRequestId;

import org.jilt.Builder;
import org.jilt.BuilderStyle;
import org.jilt.Opt;

import lombok.Data;

@Data
public class ContactRequest {
  private ContactRequestId id;
  private UserDBId receiverUserId;
  private UserDBId requestUserId;

  @Builder(style = BuilderStyle.STAGED)
  public ContactRequest(@Opt ContactRequestId id, UserDBId receiverUserId, UserDBId requestUserId) {
    this.id = id;
    this.receiverUserId = receiverUserId;
    this.requestUserId = requestUserId;
  }

  public void assertManadatoryField() {
    Assert.notNull("receiverUserId", receiverUserId);
    Assert.notNull("requestUserId", requestUserId);
  }

  public static ContactRequest builderRequest(User sender, User receiver) {

    return ContactRequestBuilder.contactRequest()
        .receiverUserId(receiver.getDbId())
        .requestUserId(sender.getDbId())
        .build();

  }

}
