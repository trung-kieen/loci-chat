package com.loci.loci_backend.common.jpa;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

public class PageDefaults {

  public static final Pageable FRIEND_SEARCH_PAGE = PageRequest.of(0, 10);

}
