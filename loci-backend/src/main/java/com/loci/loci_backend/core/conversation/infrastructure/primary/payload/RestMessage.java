package com.loci.loci_backend.core.conversation.infrastructure.primary.payload;

import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RestMessage {
  private UUID messageId;
  private String content;
}
