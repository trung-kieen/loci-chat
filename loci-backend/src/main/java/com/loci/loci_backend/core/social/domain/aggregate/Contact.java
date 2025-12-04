package com.loci.loci_backend.core.social.domain.aggregate;

import com.loci.loci_backend.common.user.domain.vo.UserDBId;
import com.loci.loci_backend.core.social.domain.vo.ContactId;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

import lombok.Data;

@Data
public class Contact {
  private ContactId contactId;
  private UserDBId ownUserId;
  private UserDBId contactUserId;
  private UserDBId blockByUserId;
  @Builder(style = BuilderStyle.STAGED)
  public Contact(ContactId contactId, UserDBId ownUserId, UserDBId contactUserId, UserDBId blockByUserId) {
    this.contactId = contactId;
    this.ownUserId = ownUserId;
    this.contactUserId = contactUserId;
    this.blockByUserId = blockByUserId;
  }
}
