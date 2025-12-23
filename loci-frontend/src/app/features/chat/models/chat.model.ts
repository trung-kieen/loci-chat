

export type  ConversationType = 'one to one' | 'group';
export interface Message {
  // TODO
  id: string
}

export interface ConversationPreview {
  id: string,
  conversationType: ConversationType,
  unreadCount: number,
  lastMessage: Message,
  createDate: Date,
}
