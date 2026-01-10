package com.loci.loci_backend.core.identity.domain.repository;

import com.loci.loci_backend.common.translation.BatchIdTranslator;
import com.loci.loci_backend.common.translation.IdTranslator;
import com.loci.loci_backend.common.user.domain.vo.PublicId;
import com.loci.loci_backend.common.user.domain.vo.UserDBId;

public interface UserIdTranslator extends IdTranslator<PublicId, UserDBId>, BatchIdTranslator<PublicId, UserDBId> {




}
