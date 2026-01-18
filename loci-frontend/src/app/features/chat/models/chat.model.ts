export type ConversationType = 'one to one' | 'group';
import { Page } from '../../../core/model/page';
import { FriendshipStatus } from '../../contact/models/contact.model';
export interface IMessage {
  // TODO
  messageId: string;
}

export interface IChatReference {
  conversationId: string;
  conversationType: ConversationType;
  unreadCount: number;
  lastMessage: IMessage;
  createDate: Date;
}

export interface ICreatedGroupResponse {
  chat: IChatReference;
  group: IGroupMetadata;
}

export interface ICreateGroupRequest {
  groupName: string;
  // imageUrl: string | null;
  memberIds: string[]; // init member ids
}

export interface IUpdateGroupImage {
  imageUrl: string;
}

export interface IUpdateGroupProfile {
  groupName: string;
}

export interface IGroupMetadata {
  groupId: string;
  groupName: string;
  groupPictureUrl: string;
}

export interface IFriend {
  userId: string;
  fullname: string;
  username: string;
  email: string;
  imageUrl: string;
  friendshipStatus: FriendshipStatus;
}

export interface IFriendList {
  friends: Page<IFriend>;
}
