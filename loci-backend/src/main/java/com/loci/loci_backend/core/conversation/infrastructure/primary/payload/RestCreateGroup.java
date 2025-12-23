package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

@Builder(style = BuilderStyle.STAGED)
public record RestCreateGroup(
    String groupName,
    String profileImage) {
}
