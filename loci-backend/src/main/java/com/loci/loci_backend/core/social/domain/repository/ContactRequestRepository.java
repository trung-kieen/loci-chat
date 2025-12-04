package com.loci.loci_backend.core.social.domain.repository;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;

public interface ContactRequestRepository {
  public boolean existsPendingRequest(User a, User b);

  public ContactRequest save(ContactRequest contactRequest);

}
