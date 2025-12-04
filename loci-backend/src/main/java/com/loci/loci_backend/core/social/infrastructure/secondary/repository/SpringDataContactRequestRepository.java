package com.loci.loci_backend.core.social.infrastructure.secondary.repository;

import java.util.List;

import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.core.social.domain.aggregate.ContactRequest;
import com.loci.loci_backend.core.social.domain.repository.ContactRequestRepository;
import com.loci.loci_backend.core.social.infrastructure.secondary.entity.ContactRequestEntity;
import com.loci.loci_backend.core.social.infrastructure.secondary.mapper.ContactEntityMapper;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SpringDataContactRequestRepository implements ContactRequestRepository {
  private final JpaContactRequestRepository repository;
  private final ContactEntityMapper mapper;

  @Override
  public boolean existsPendingRequest(User a, User b) {
    Specification<ContactRequestEntity> spec = JpaContactRequestSpecification.searchContactRequest(a.getDbId().value(),
        b.getDbId().value());
    List<ContactRequestEntity> requests = repository.findAll(spec);
    return requests.size() > 0;
  }

  @Override
  public ContactRequest save(ContactRequest contactRequest) {
    ContactRequestEntity request = mapper.from(contactRequest);
    return mapper.toDomain(repository.save(request));
  }

}
