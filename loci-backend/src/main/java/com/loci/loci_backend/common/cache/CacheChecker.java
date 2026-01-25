package com.loci.loci_backend.common.cache;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.SmartInitializingSingleton;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.support.CompositeCacheManager;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j2;

/**
 *
 * Check for report available caching provider
 *
 * Use SmartInitializingSingleton instead of ContextRefreshedEvent to avoid
 * defer bean intilization
 */
@Component
@Log4j2
public class CacheChecker implements SmartInitializingSingleton {

  private final String cacheType;

  // all bean for cachemanager
  private final List<CacheManager> allCacheManagers;

  private final CacheManager primaryCacheManager;

  public CacheChecker(List<CacheManager> allCacheManagers,
      @Autowired(required = false) CacheManager primaryCacheManager,
      @Value("${spring.cache.type:none}") String cacheType) {

    this.allCacheManagers = allCacheManagers;
    this.primaryCacheManager = primaryCacheManager;
    this.cacheType = cacheType;
  }

  public void reportCacheConfiguration() {
    log.info("Total CacheManagers found: {}", allCacheManagers.size());
    log.info("Cache type: {}", cacheType);

    allCacheManagers.forEach(manager -> {
      boolean isPrimary = manager == primaryCacheManager;
      String type = manager.getClass().getSimpleName();
      Collection<String> cacheNames = manager.getCacheNames();

      log.info("[{}] CacheManager Type: {} | Caches: {}",
          isPrimary ? "PRIMARY" : "Secondary",
          type,
          cacheNames);

      // Detail each cache type
      if (!cacheNames.isEmpty()) {
        cacheNames.forEach(cacheName -> {
          Cache cache = manager.getCache(cacheName);
          if (cache != null) {
            log.debug("  - Cache Provider '{}': {}", cacheName, cache.getClass().getSimpleName());
          }
        });
      }
    });

    // Log composite details if use hybrid
    if (primaryCacheManager instanceof CompositeCacheManager) {
      log.info("Using COMPOSITE mode - lookup order: Local → Redis");
    }
  }

  @Override
  public void afterSingletonsInstantiated() {
    reportCacheConfiguration();
  }

}
