package com.loci.loci_backend.common.user.infrastructure.secondary.entity;

import java.time.Instant;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import com.loci.loci_backend.common.jpa.AbstractAuditingEntity;
import com.loci.loci_backend.common.util.NullSafe;
import com.loci.loci_backend.core.identity.domain.aggregate.PersonalProfileChanges;
import com.loci.loci_backend.core.identity.domain.aggregate.PrivacySetting;
import com.loci.loci_backend.core.identity.domain.vo.FriendRequestSettingEnum;
import com.loci.loci_backend.core.identity.domain.vo.LastSeenSettingEnum;
import com.loci.loci_backend.core.identity.domain.vo.ProfileVisibility;
import com.loci.loci_backend.core.identity.domain.vo.UserFriendRequestSetting;
import com.loci.loci_backend.core.identity.domain.vo.UserLastSeenSetting;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "USER_")
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserEntity extends AbstractAuditingEntity<Long> {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "userSequenceGenerator")
  @SequenceGenerator(name = "userSequenceGenerator", sequenceName = "user_sequence", allocationSize = 1)
  @Column(name = "id")
  private Long id;

  @NotBlank
  private String email;

  @NotBlank
  private String username;

  @NotBlank
  private String firstname;

  @NotBlank
  private String lastname;

  @Column(name = "profile_picture")
  private String profilePicture;

  @Column(name = "public_id")
  private UUID publicId;

  private String bio;

  @Column(name = "last_active")
  private Instant lastActive;

  // Profile settings
  @Column(name = "last_seen_setting")
  @Enumerated(EnumType.STRING)
  private LastSeenSettingEnum lastSeenSetting = LastSeenSettingEnum.EVERYONE;

  @Column(name = "friend_request_setting")
  private FriendRequestSettingEnum friendRequestSetting = FriendRequestSettingEnum.EVERYONE;

  @Column(name = "profile_visibility")
  private Boolean profileVisibility = true;

  @ManyToMany(cascade = CascadeType.REMOVE)
  @JoinTable(name = "user_authority", joinColumns = {
      @JoinColumn(name = "user_id", referencedColumnName = "id")
  },
      inverseJoinColumns = {
          @JoinColumn(name = "authority_name", referencedColumnName = "name")

      }
  )
  private Set<AuthorityEntity> authorities = new HashSet<>();

  // @Column
  // @Enumerated(EnumType.STRING)
  // private Gender gender;
  //
  // public enum Gender {
  // MALE, FEMALE
  // }

  public String getUsername() {
    return username;

  }

  public void applyChanges(PersonalProfileChanges changes) {
    NullSafe.applyIfPresent(changes::getFullname, fullname -> {
      NullSafe.applyIfPresent(fullname::getFirstname, fn -> this.firstname = fn.value());
      NullSafe.applyIfPresent(fullname::getLastname, ln -> this.lastname = ln.value());
    });

    NullSafe.applyIfPresent(changes::getImageUrl, iu -> this.profilePicture = iu.value());

    NullSafe.applyIfPresent(changes::getPrivacySetting, ps -> {
      NullSafe.applyIfPresent(ps::getLastSeenSetting, lss -> this.lastSeenSetting = lss.value());
      NullSafe.applyIfPresent(ps::getFriendRequestSetting, frs -> this.friendRequestSetting = frs.value());
      NullSafe.applyIfPresent(ps::getProfileVisibility, pv -> this.profileVisibility = pv.value());
    });
  }

  public PrivacySetting getPrivacySetting() {
    return PrivacySetting.builder()
        .lastSeenSetting(UserLastSeenSetting.ofEnum(this.lastSeenSetting))
        .friendRequestSetting(UserFriendRequestSetting.ofEnum(this.friendRequestSetting))
        .profileVisibility(ProfileVisibility.of(this.profileVisibility))
        .build();
  }

  @Override
  public Long getId() {
    return id;
  }

}
