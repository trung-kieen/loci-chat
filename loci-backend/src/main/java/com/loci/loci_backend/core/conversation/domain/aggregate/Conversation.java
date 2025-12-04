package com.loci.loci_backend.core.conversation.domain.aggregate;

// public class Conversation {
//   private final ConversationId conversationId;
//   private final PublicId creatorId;
//   private final Set<Participant> participants = new HashSet<>();
//   private final List<Message> messages = new ArrayList<>();
//   private final Instant createdAt;
//   private String groupName; // null for 1-1 chats
//   private String groupProfilePicture;
//   private MessageId lastMessageId;
//   private boolean deleted = false;
//
//   // Factory method for 1-1 conversation
//   public static Conversation createOneToOne(PublicId creatorId, PublicId otherUserId) {
//     Conversation conversation = new Conversation(creatorId);
//     conversation.addParticipant(creatorId, ParticipantRole.ADMIN);
//     conversation.addParticipant(otherPublicId, ParticipantRole.MEMBER);
//     return conversation;
//   }
//
//   // Factory method for group
//   public static Conversation createGroup(PublicId creatorId, String groupName, Set<PublicId> initialMembers) {
//     Conversation conversation = new Conversation(creatorId);
//     conversation.groupName = groupName;
//     conversation.addParticipant(creatorId, Participant.Role.ADMIN);
//     initialMembers.forEach(memberId -> conversation.addParticipant(memberId, ParticipantRole.MEMBER));
//     return conversation;
//   }
//
//   private Conversation(PublicId creatorId) {
//     this.conversationId = ConversationId.generate();
//     this.creatorId = creatorId;
//     this.createdAt = Instant.now();
//   }
//
//   // Business Methods - Enforce Invariants
//   public Message sendMessage(PublicId senderId, MessageContent content) {
//     if (!isParticipant(senderId)) {
//       throw new UnauthorizedActionException("Only participants can send messages");
//     }
//     if (deleted) {
//       throw new IllegalStateException("Cannot send messages in deleted conversation");
//     }
//
//     Message message = new Message(senderId, content);
//     message.markAsSent();
//     messages.add(message);
//     lastMessageId = message.getMessageId();
//
//     // Domain Event - published by Application Service later
//     // registerEvent(new MessageSentEvent(conversationId, message));
//     registerEvent(new RuntimeException(conversationId, message));
//
//     return message;
//   }
//
//   public void addParticipant(PublicId userId, ParticipantRole role) {
//     if (isParticipant(userId)) {
//       // throw new DuplicateParticipantException("User already in conversation");
//       throw new RuntimeException("User already in conversation");
//     }
//
//     participants.add(new Participant(userId, role));
//   }
//
//   public void markMessageAsDelivered(MessageId messageId) {
//     findMessage(messageId).ifPresent(Message::markAsDelivered);
//   }
//
//   public void markMessageAsSeen(PublicId userId, MessageId messageId) {
//     if (!isParticipant(userId)) {
//       throw new UnauthorizedActionException("Only participants can see messages");
//     }
//
//     Participant participant = getParticipant(userId);
//     participant.updateLastRead(messageId);
//     findMessage(messageId).ifPresent(Message::markAsSeen);
//   }
//
//   private boolean isParticipant(PublicId userId) {
//     return participants.stream().anyMatch(p -> p.getPublicId().equals(userId));
//   }
//
//   private Participant getParticipant(PublicId userId) {
//     return participants.stream()
//         .filter(p -> p.getPublicId().equals(userId))
//         .findFirst()
//         .orElseThrow(() -> new ParticipantNotFoundException(userId));
//   }
//
//   private Optional<Message> findMessage(MessageId messageId) {
//     return messages.stream()
//         .filter(m -> m.getMessageId().equals(messageId))
//         .findFirst();
//   }
//
//   // Getters
//   public ConversationId getConversationId() {
//     return conversationId;
//   }
//
//   public Set<Participant> getParticipants() {
//     return Collections.unmodifiableSet(participants);
//   }
//
//   public List<Message> getMessages() {
//     return Collections.unmodifiableList(messages);
//   }
// }
