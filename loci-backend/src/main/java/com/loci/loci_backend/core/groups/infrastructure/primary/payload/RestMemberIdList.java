package com.loci.loci_backend.core.groups.infrastructure.primary.payload;

import java.util.Set;
import java.util.UUID;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RestMemberIdList {
  private Set<UUID> ids; // public Id

}
