package com.loci.loci_backend.core.conversation.domain.repository;

import java.util.Collection;
import java.util.List;

import com.loci.loci_backend.core.conversation.domain.aggregate.Conversation;
import com.loci.loci_backend.core.conversation.domain.aggregate.Participant;

public interface ParticipantRepository {


  List<Participant> addParticipants(Conversation conversation, Collection<Participant> participants);

}
