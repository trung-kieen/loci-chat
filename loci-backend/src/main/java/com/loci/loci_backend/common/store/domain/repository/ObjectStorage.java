package com.loci.loci_backend.common.store.domain.repository;

import java.io.InputStream;

import com.loci.loci_backend.common.store.domain.aggregate.File;
import com.loci.loci_backend.common.store.domain.vo.FileContentType;
import com.loci.loci_backend.common.store.domain.vo.FileInputStream;
import com.loci.loci_backend.common.store.domain.vo.FilePath;

public interface ObjectStorage {

  File saveObject(FilePath filePath, FileInputStream file, FileContentType contentType);

  void deleteObject(FilePath filePath);

  File getObject(FilePath filePath);

}
