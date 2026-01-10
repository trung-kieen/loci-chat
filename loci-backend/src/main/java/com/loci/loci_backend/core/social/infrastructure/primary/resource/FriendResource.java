package com.loci.loci_backend.core.social.infrastructure.primary.resource;

import java.util.UUID;

import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.core.discovery.domain.aggregate.FriendList;
import com.loci.loci_backend.core.discovery.domain.vo.SearchQuery;
import com.loci.loci_backend.core.discovery.infrastructure.primary.mapper.RestFriendMapper;
import com.loci.loci_backend.core.discovery.infrastructure.primary.payload.RestFriendList;
import com.loci.loci_backend.core.social.application.SocialApplicationService;
import com.loci.loci_backend.core.social.domain.vo.FriendshipStatus;
import com.loci.loci_backend.core.social.infrastructure.primary.payload.RestFriendshipUpdatedResponse;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import jakarta.ws.rs.QueryParam;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/friends")
public class FriendResource {

  private final SocialApplicationService socialApplicationService;
  private final RestFriendMapper restFriendMapper;

  @DeleteMapping("/{friendId}")
  @ResponseStatus(HttpStatus.OK)
  public RestFriendshipUpdatedResponse removeFriendContact(@PathVariable("friendId") UUID userId) {
    PublicId userPublicId = new PublicId(userId);
    socialApplicationService.removeContactConnection(userPublicId);
    return new RestFriendshipUpdatedResponse(FriendshipStatus.notConnected());
  }

  @GetMapping
  @ResponseStatus(HttpStatus.OK)
  public RestFriendList findFirend(@QueryParam(value = "q") String query) {
    SearchQuery searchQuery = new SearchQuery(query);
    FriendList friends = socialApplicationService.searchFriend(searchQuery);

    return restFriendMapper.from(friends);
    // return new RestFriendshipUpdatedResponse(FriendshipStatus.notConnected());
  }

}
