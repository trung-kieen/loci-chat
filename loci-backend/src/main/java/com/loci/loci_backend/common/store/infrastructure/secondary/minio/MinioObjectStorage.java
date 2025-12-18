package com.loci.loci_backend.common.store.infrastructure.secondary.minio;

import java.io.InputStream;

import com.loci.loci_backend.common.store.domain.aggregate.File;
import com.loci.loci_backend.common.store.domain.aggregate.FileBuilder;
import com.loci.loci_backend.common.store.domain.repository.ObjectStorage;
import com.loci.loci_backend.common.store.domain.vo.FileContentType;
import com.loci.loci_backend.common.store.domain.vo.FileInputStream;
import com.loci.loci_backend.common.store.domain.vo.FilePath;
import com.loci.loci_backend.common.store.infrastructure.primary.vo.MinioPath;

import io.minio.GetObjectArgs;
import io.minio.MinioClient;
import io.minio.ObjectWriteResponse;
import io.minio.PutObjectArgs;
import io.minio.RemoveObjectArgs;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MinioObjectStorage implements ObjectStorage {

  private final MinioClient minioClient;
  private final MinioProperties configurationProperties;

  public MinioObjectStorage(MinioClient client, MinioProperties config) {
    super();
    this.minioClient = client;
    this.configurationProperties = config;
  }

  @SneakyThrows
  @Override
  public File saveObject(FilePath path, FileInputStream file, FileContentType contentType) {
    InputStream inputStream = file.value();
    MinioPath uploadPath = new MinioPath(path.value());
    log.info("Designate image path for upload path {}", uploadPath);
    PutObjectArgs args = PutObjectArgs.builder()
        .bucket(configurationProperties.getBucket())
        .object(uploadPath.value())
        .stream(inputStream, inputStream.available(), -1)
        // .headers(headers)
        .contentType(contentType.value())
        .build();
    ObjectWriteResponse response = minioClient.putObject(args);
    log.info("Minio put response:{}", response);
    FilePath fullPath = uploadPath.fullPath(configurationProperties);
    log.debug("File success upload to {}", fullPath);
    return FileBuilder.file()
        .stream(new FileInputStream(inputStream))
        .path(fullPath)
        .build();
  }

  @SneakyThrows
  @Override
  public void deleteObject(FilePath path) {
    String filePath = path.value();
    minioClient.removeObject(RemoveObjectArgs
        .builder()
        .bucket(configurationProperties.getBucket())
        .object(filePath)
        .build());
  }

  @SneakyThrows
  @Override
  public File getObject(FilePath path) {
    MinioPath filePath = new MinioPath(path.value());
    FileInputStream stream = new FileInputStream(minioClient.getObject(
        GetObjectArgs.builder()
            .bucket(configurationProperties.getBucket())
            .object(filePath.value())
            .build()));
    // Return with with prefix is minio self host with fix or s3 global unique
    FilePath fullPath = filePath.fullPath(configurationProperties);
    return FileBuilder.file()
        .stream(stream)
        .path(fullPath)
        .build();
  }

}
