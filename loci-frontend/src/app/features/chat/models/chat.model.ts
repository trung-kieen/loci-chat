

export type ConversationType = 'one to one' | 'group';
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

export interface CreateGroupData {
  groupName: string,
  imageUrl: string | null,
  memberIds: string[], // init member ids
}

export interface Friend {
  id: string,
  name: string,
  username: string,
  imageUrl: string,
}

export interface FriendList {
  friends: Friend[]
}
