package com.loci.loci_backend.core.social.infrastructure.secondary.mapper;

import com.loci.loci_backend.common.user.domain.vo.UserDBId;
import com.loci.loci_backend.common.util.NullSafe;
import com.loci.loci_backend.core.social.domain.aggregate.Contact;
import com.loci.loci_backend.core.social.domain.aggregate.ContactBuilder;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.vo.ContactId;
import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactEntity;
import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactRequestEntity;
import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactRequestEntityBuilder;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ContactEntityMapper {
  private final MapStructContactEntityMapper contactMapper;

  public Contact toDomain(ContactEntity entity) {
    return ContactBuilder.contact().contactId(new ContactId(entity.getId()))
        .ownUserId(new UserDBId(entity.getOwningUser().getId()))
        .contactUserId(new UserDBId(entity.getContactUser().getId()))
        .blockByUserId(NullSafe.getIfPresent(entity.getBlockedBy(), (userEntity) -> new UserDBId(userEntity.getId())))
        .build();
  }

  public ContactRequest toDomain(ContactRequestEntity entity) {
    return contactMapper.toDomain(entity);
  }

  public ContactRequestEntity from(ContactRequest contactRequest) {
    return contactMapper.from(contactRequest);
  }

}
