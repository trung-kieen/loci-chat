package com.loci.loci_backend.common.store.infrastructure.secondary.s3;

import java.io.InputStream;

import com.loci.loci_backend.common.store.domain.aggregate.File;
import com.loci.loci_backend.common.store.domain.service.FileStorageService;
import com.loci.loci_backend.common.store.domain.vo.FileContentType;
import com.loci.loci_backend.common.store.domain.vo.FileInputStream;
import com.loci.loci_backend.common.store.domain.vo.FilePath;
import com.loci.loci_backend.common.store.infrastructure.secondary.minio.MinioProperties;

import io.minio.GetObjectArgs;
import io.minio.ObjectWriteResponse;
import io.minio.RemoveObjectArgs;
import lombok.SneakyThrows;
import lombok.extern.log4j.Log4j2;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

/**
 *
 * Minio already fully compatible with the Amazon S3 API
 * Use MinioClient instead
 */



// @Log4j2
// public class S3FileService implements FileStorageService {
//
//   private final S3Client minioClient;
//   private final MinioConfigurationProperties configurationProperties;
//
//   public S3FileService(S3Client client, MinioConfigurationProperties config) {
//     super();
//     this.minioClient = client;
//     this.configurationProperties = config;
//   }
//
//   @SneakyThrows
//   @Override
//   public File saveFile(FilePath path, FileInputStream file, FileContentType contentType) {
//     InputStream inputStream = file.value();
//     String uploadFilePath = path.value();
//     PutObjectRequest args = PutObjectRequest.builder()
//         .bucket(configurationProperties.getBucket())
//         .key(uploadFilePath)
//         // .headers(headers)
//         .contentType(contentType.value())
//         .build();
//
//     var body =  RequestBody.fromInputStream(inputStream, inputStream.available());
//     ObjectWriteResponse response = minioClient.putObject(args, body);
//     log.info("minio put response:{}", response);
//     String fullPath = configurationProperties.getUrlPrefix() + configurationProperties.getBucket() + "/"
//         + uploadFilePath;
//     return new File(new FilePath(fullPath));
//   }
//
//   @SneakyThrows
//   @Override
//   public void deleteObject(FilePath path) {
//     String filePath = path.value();
//     minioClient.removeObject(RemoveObjectArgs
//         .builder()
//         .bucket(configurationProperties.getBucket())
//         .object(filePath)
//         .build());
//   }
//
//   @SneakyThrows
//   @Override
//   public InputStream getFile(FilePath path) {
//     String filePath = path.value();
//     return minioClient.getObject(
//         GetObjectArgs.builder()
//             .bucket(configurationProperties.getBucket())
//             .object(filePath)
//             .build());
//   }
// }
