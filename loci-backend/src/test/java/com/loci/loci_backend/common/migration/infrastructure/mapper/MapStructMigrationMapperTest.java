package com.loci.loci_backend.common.migration.infrastructure.mapper;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.loci.loci_backend.common.authentication.domain.Username;
import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.domain.vo.UserEmail;
import com.loci.loci_backend.common.user.domain.vo.UserFirstname;
import com.loci.loci_backend.common.user.domain.vo.UserLastname;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {
    MapStructMigrationMapperImpl.class, // the generated implementation
})
public class MapStructMigrationMapperTest {

  @Autowired
  private MapStructMigrationMapper mapper;

  @Test
  public void testMappingValidUser() throws Exception {

    var user = new User();
    var firstname = new UserFirstname("about");
    var lastname = new UserLastname("company");
    var email = new UserEmail("exampleemail@gmail.com");
    var username = new Username("enjoy");
    user.setFirstname(firstname);
    user.setLastname(lastname);
    user.setEmail(email);
    user.setUsername(username);

    var keycloakUser = mapper.toKeycloakUser(user);
    assertEquals(keycloakUser.getFirstName(), firstname);
    assertEquals(keycloakUser.getLastName(), lastname);
    assertEquals(keycloakUser.getEmail(), email);
    assertEquals(keycloakUser.getUsername(), username);
    assertEquals(keycloakUser.getUsername(), username);

  }

}
