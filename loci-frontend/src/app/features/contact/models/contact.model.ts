
export interface ContactSearchItem {
  userId: string;
  fullname: string;
  username: string;
  email: string;
  imageUrl: string;
  friendshipStatus: 'none' | 'pending' | 'friends';
}
