package com.loci.loci_backend.core.groups.infrastructure.primary.payload;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RestGroupProfileChanges {

  private String groupName;

  private String groupProfilePicture;

}
