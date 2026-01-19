package com.loci.loci_backend.common.store.domain.aggregate;

import com.loci.loci_backend.common.store.domain.vo.FileContentType;
import com.loci.loci_backend.common.store.domain.vo.FileInputStream;
import com.loci.loci_backend.common.store.domain.vo.FilePath;

import org.jilt.Builder;

@Builder
public record File(FilePath path, FileInputStream stream, FileContentType contentType) {

}
