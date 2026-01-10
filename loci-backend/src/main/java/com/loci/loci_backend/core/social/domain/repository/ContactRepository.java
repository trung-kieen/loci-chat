package com.loci.loci_backend.core.social.domain.repository;

import java.util.List;
import java.util.Optional;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.vo.UserDBId;
import com.loci.loci_backend.core.discovery.domain.aggregate.Friend;
import com.loci.loci_backend.core.discovery.domain.vo.SearchQuery;
import com.loci.loci_backend.core.social.domain.aggregate.ContactConnection;

public interface ContactRepository {
  public Optional<ContactConnection> searchContact(UserDBId a, UserDBId b);

  public Optional<ContactConnection> searchContact(User a, User b);

  public boolean existsContactConnection(User a, User b);

  public ContactConnection save(ContactConnection contact);

  public void removeContact(UserDBId a, UserDBId b);
  public void delete(ContactConnection contact);

  public List<Friend> findConnectedWithUser(SearchQuery query,UserDBId userId);
}
