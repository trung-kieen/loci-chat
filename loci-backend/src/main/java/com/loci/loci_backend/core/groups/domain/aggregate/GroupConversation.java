package com.loci.loci_backend.core.groups.domain.aggregate;

import java.util.Set;

import com.loci.loci_backend.common.user.domain.vo.UserDBId;
import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;

import org.jilt.Builder;
import org.jilt.BuilderStyle;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class GroupConversation {

  private Conversation conversation;

  private UserDBId creator;

  private Set<UserDBId> memberIds;

  // private List<Message> messages;

  @Builder(style = BuilderStyle.STAGED)
  public GroupConversation(Conversation conversation, UserDBId creator, Set<UserDBId> memberIds) {
    this.conversation = conversation;
    this.creator = creator;
    this.memberIds = memberIds;
  }
}
