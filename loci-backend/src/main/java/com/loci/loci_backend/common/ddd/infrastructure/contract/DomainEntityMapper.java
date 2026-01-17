package com.loci.loci_backend.common.ddd.infrastructure.contract;

/**
 * Convert from domain (D) to entity (E) and reverse
 */
public interface DomainEntityMapper<D, E> extends Domain2EntityMapper<D, E>, Entity2DomainMapper<E, D> {

}
