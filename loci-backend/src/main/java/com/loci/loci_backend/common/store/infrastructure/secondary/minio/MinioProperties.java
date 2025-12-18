package com.loci.loci_backend.common.store.infrastructure.secondary.minio;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import lombok.Data;

// @Profile("minio")
@Data
@Configuration
@Component
@ConfigurationProperties(prefix = "upload.minio")
public class MinioProperties {
  // Endpoint URL for minio host, set empty for S3)
  private String scheme = "http";
  private String url;
  private String accessKey;
  private String secretKey;

  // Https required
  private boolean secure = false;

  // S3 use for global unique identify
  private String bucket;
  private String metricName;


  // Required protocol if use minio self host
  private String urlPrefix;
  private String region = "us-east-1";

  // True for MinIO;
  private boolean forcePathStyle = false;
}
