package com.loci.loci_backend.common.user.domain.service;

import java.util.Optional;
import java.util.Set;

import com.loci.loci_backend.common.user.domain.aggregate.Authority;
import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.repository.AuthorityRepository;
import com.loci.loci_backend.common.user.domain.repository.UserRepository;
// removed direct JPA repository usage - use domain repository instead

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class UserSynchronizeService {

  private final UserRepository userRepository;
  private final AuthorityRepository authorityRepository;

  @Transactional(readOnly = false)
  public void syncUser(User user) {
    if (user == null) {
      throw new EntityNotFoundException("Error while user sync not accept null user from Oauth2 Provider");
    }
    log.debug("Receive user from oauth2 provider {}", user);

    User userToPersistence = user;
    Optional<User> oldDbUser = userRepository.getByUsername(user.getUsername());

    if (oldDbUser.isPresent()) {
      userToPersistence = oldDbUser.get();
      log.debug("Found user from database {}", oldDbUser.get());
      userToPersistence.syncOauth2User(user);
      log.debug("Database user had updated {}", userToPersistence);
    } else {

      // Confirm the authority is exist in database and save them consistently
      Set<Authority> authorities = authorityRepository.saveAll(user.getAuthorities());
      userToPersistence.setAuthorities(authorities);
    }
    userToPersistence.provideMandatoryField();
    userRepository.save(userToPersistence);
  }

}
