package com.loci.loci_backend.common.authentication.domain;

import com.loci.loci_backend.common.util.ValueObject;

public record KeycloakUserId(String value) implements ValueObject<String> {
}
