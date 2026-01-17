package com.loci.loci_backend.common.ddd.infrastructure.contract;

public interface DomainRestMapper<D, R> extends Domain2RestMapper<D, R>, Rest2DomainMapper<R, D> {

}
