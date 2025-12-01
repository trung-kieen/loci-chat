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

    User finalUser = user;
    Optional<User> dbUser = userRepository.getByUsername(user.getUsername());

    if (dbUser.isPresent()) {
      finalUser = dbUser.get();
      log.debug("Found user from database {}", dbUser.get());
      finalUser.updateFromUser(user);
      log.debug("Database user had updated {}", finalUser);
    } else {

      // Confirm the authority is exist in database and save them consistently
      Set<Authority> authorities = authorityRepository.saveAll(user.getAuthorities());
      finalUser.setAuthorities(authorities);
    }
    finalUser.provideMandatoryField();
    userRepository.save(finalUser);
  }

}
