export type ConversationType = 'one to one' | 'group';
export interface IMessage {
  // TODO
  messageId: string;
}

export interface IChatPreview {
  conversationId: string;
  conversationType: ConversationType;
  unreadCount: number;
  lastMessage: IMessage;
  createDate: Date;
}

export interface ICreateGroupRequest {
  groupName: string;
  imageUrl: string | null;
  memberIds: string[]; // init member ids
}

export interface IFriend {
  userId: string;
  name: string;
  username: string;
  imageUrl: string;
}

export interface IFriendList {
  friends: IFriend[];
}
