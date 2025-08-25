package com.loci.loci_backend.chat.infrastructure.secondary;

import com.loci.loci_backend.common.jpa.AbstractAuditingEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "MESSAGE")
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MessageEntity extends AbstractAuditingEntity<Long>{
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "messageSequenceGenerator")
  @SequenceGenerator(name = "messageSequenceGenerator", sequenceName = "message_sequence", allocationSize = 1)
  @Column(name = "id")
  private Long id;

  @Override
  public Long getId() {
    // TODO Auto-generated method stub
    return id;
  }


}
