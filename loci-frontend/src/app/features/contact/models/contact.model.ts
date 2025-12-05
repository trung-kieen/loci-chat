
// export type ConnectionStatus =
//   | 'not_connected'
//   | 'friend_request_sent'
//   | 'friend_request_received'
//   | 'friend'
//   | 'unfriended'
//   | 'blocked'
//   | 'blocked_by'
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
