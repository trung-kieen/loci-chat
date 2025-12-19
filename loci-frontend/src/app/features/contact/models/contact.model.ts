
// export type ConnectionStatus =
//   | 'not_connected'
//   | 'friend_request_sent'
//   | 'friend_request_received'
//   | 'friend'
//   | 'unfriended'
//   | 'blocked'
//   | 'blocked_by'

import { Page } from "../../../core/model/page";

//   | 'not_determined';
export type FriendshipStatus =
  | 'not_connected'
  | 'friend_request_sent'
  | 'friends'
  | 'not_determined'
  | 'friend_request_received'
  | 'blocked'
  | 'blocked_by';

export interface ContactSearchItem {
  userId: string;
  fullname: string;
  username: string;
  email: string;
  imageUrl: string;
  friendshipStatus: FriendshipStatus;
}

export interface SearchContactList {
  contacts: Page<ContactSearchItem>;
}



export interface FriendRequestList {
  requests: Page<ConntectRequested>;
}



export interface FriendSuggestionList {
  contacts: Page<FriendSuggestion>;
}
export interface ConntectRequested extends ContactSearchItem {
  mutualConnections: number,
}
export interface FriendSuggestion extends ContactSearchItem {
  bio: string,
  mutualConnections: number,
}
