package com.loci.loci_backend.core.discovery.domain.aggregate;

import org.springframework.data.domain.Page;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class FriendList {
  // Limit about 10 user?
  private Page<Friend> friends;

}
