package com.loci.loci_backend.common.store.infrastructure.secondary.s3;

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
