package com.loci.loci_backend.core.discovery.domain.aggregate;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class FriendList {
  private List<Friend> friends;

}
