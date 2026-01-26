package com.loci.loci_backend;

import java.util.Random;
import java.util.UUID;
import lombok.extern.log4j.Log4j2;

import com.github.javafaker.Faker;
import com.loci.loci_backend.common.user.infrastructure.secondary.repository.JpaUserRepository;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.entity.ConversationEntity;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.repository.JpaConversationRepository;
import com.loci.loci_backend.core.conversation.infrastructure.secondary.repository.JpaParticipantRepository;
import com.loci.loci_backend.core.messaging.domain.vo.MessageState;
import com.loci.loci_backend.core.messaging.domain.vo.MessageType;
import com.loci.loci_backend.core.messaging.infrastructure.secondary.entity.MessageEntityBuilder;
import com.loci.loci_backend.core.messaging.infrastructure.secondary.repository.JpaMessageRepository;
import com.loci.loci_backend.core.social.infrastructure.secondary.repository.JpaContactRepository;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
@Log4j2
public class InitializeData implements CommandLineRunner {
  private final JpaUserRepository userRepository;
  private final JpaContactRepository contactRepository;
  private final JpaConversationRepository conversationRepository;
  private final JpaParticipantRepository participantRepository;
  private final JpaMessageRepository messageRepository;
  private final Faker faker = new Faker();

  @Override
  public void run(String... args) throws Exception {
    log.info("Init data fro application");
    var users = userRepository.findAll();

    var contacts = contactRepository.findAll();

    var conversation = conversationRepository.findAll();
    for (var con : conversation) {
      generateMessage(con);
    }

  }

  @Transactional(readOnly = false)
  private void generateMessage(ConversationEntity con) {

    log.debug("Init data for conversation {}", con.getId());
    var conversationId = con.getId();
    var participantIds = participantRepository.getUserIdInConversation(conversationId);
    var ran = new Random();

    for (var userId : participantIds) {

      var message = MessageEntityBuilder.messageEntity()
          .id(null)
          .publicId(UUID.randomUUID())
          .conversationId(conversationId)
          .senderId(userId)
          .content(faker.chuckNorris().fact())
          .type(MessageType.TEXT)
          .replyToMessageId(null)
          .status(MessageState.SENT)
          .deleted(false)
          .build();
      messageRepository.saveAndFlush(message);
    }
  }

}
