package com.loci.loci_backend.core.identity.infrastructure.secondary.repository;

import com.loci.loci_backend.common.ddd.infrastructure.stereotype.SecondaryPort;
import com.loci.loci_backend.common.user.domain.aggregate.User;
import com.loci.loci_backend.common.user.infrastructure.secondary.entity.UserEntity;
import com.loci.loci_backend.common.user.infrastructure.secondary.mapper.UserEntityMapper;
import com.loci.loci_backend.core.identity.domain.aggregate.UserSetting;
import com.loci.loci_backend.core.identity.domain.repository.UserSettingRepository;
import com.loci.loci_backend.core.identity.infrastructure.secondary.entity.UserSettingEntity;
import com.loci.loci_backend.core.identity.infrastructure.secondary.mapper.IdentityEntityMapper;

import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;

@SecondaryPort
@RequiredArgsConstructor
public class SpringDataUserSettingRepository implements UserSettingRepository {
  private final JpaUserSettingRepository repository;
  private final EntityManager entityManager;
  private final IdentityEntityMapper mapper;
  private final UserEntityMapper userMapper;

  @Override
  @Transactional(readOnly = false)
  public UserSetting save(UserSetting settings) {
    UserSettingEntity entity = mapper.from(settings);
    UserSetting savedSettings = mapper.toDomain(repository.save(entity));
    repository.flush();
    return savedSettings;
  }

  @Transactional(readOnly = false)
  @Override
  public UserSetting createSetting(User user, UserSetting settings) {
    UserSettingEntity settingsEntity = mapper.from(settings);
    UserEntity userEntity = userMapper.from(user);
    settingsEntity.setUser(userEntity);
    // save jpa lock object
    entityManager.persist(settingsEntity);
    // UserSettingsEntity savedSettings = repository.save(settingsEntity);
    return mapper.toDomain(settingsEntity);
  }

}
