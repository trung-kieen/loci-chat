package com.loci.loci_backend.common.wire.store;

import java.net.URI;

import com.loci.loci_backend.common.store.domain.repository.ObjectStorage;
import com.loci.loci_backend.common.store.infrastructure.secondary.minio.MinioObjectStorage;
import com.loci.loci_backend.common.store.infrastructure.secondary.minio.MinioProperties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;


@Configuration
@RequiredArgsConstructor
public class StoreConfiguration {


  private final MinioProperties minioConfig;

  // @Bean
  // // @Profile("s3")
  // public S3Client s3Client() {
  //   return S3Client.builder()
  //       .endpointOverride(URI.create(minioConfig.getUrl()))
  //       // .forcePathStyle(minioConfig.getForcePathStyle())
  //       .region(Region.of(minioConfig.getRegion()))
  //       .credentialsProvider(() -> AwsBasicCredentials.create(minioConfig.getAccessKey(),
  //           minioConfig.getSecretKey()))
  //       .build();
  // }

  @SneakyThrows
  @Bean
  // @Profile("minio")
  public MinioClient minioClient() {
    MinioClient minioClient;
    minioClient = MinioClient.builder()
        .endpoint(minioConfig.getUrl())
        .region(minioConfig.getRegion())
        .credentials(minioConfig.getAccessKey(), minioConfig.getSecretKey())
        .build();



    // Create bucket via docker mc service

    // // Create bucket if not exist
    // BucketExistsArgs existsArgs = BucketExistsArgs.builder()
    //     .bucket(minioConfig.getBucket())
    //     .build();
    //
    // boolean hasExist = minioClient.bucketExists(existsArgs);
    // if (!hasExist) {
    //   MakeBucketArgs makeBucketArgs = MakeBucketArgs.builder()
    //       .bucket(minioConfig.getBucket())
    //       .build();
    //   minioClient.makeBucket(makeBucketArgs);
    // }
    return minioClient;

  }



  @Bean
  // @Profile("minio")
  public ObjectStorage minioObjectStorage(MinioClient client, MinioProperties config) {
    return new MinioObjectStorage(client, config);
  }
}
