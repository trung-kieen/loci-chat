import { FriendshipStatus } from "../../contact/models/contact.model";

export interface UpdatedStatus {
  status: FriendshipStatus,
}

export interface RecentActivity {
  id: string;
  type: 'message' | 'connection' | 'file' | 'other';
  message: string;
  timestamp: Date;
}

export interface PublicProfile {
  publicId: string;
  username: string;
  fullname: string;
  emailAddress?: string;
  profilePictureUrl: string;
  createdAt: Date;
  lastActive: Date;
  mutualFriendCount: number;
  connectionStatus: FriendshipStatus;
  showEmail: boolean;
  showLastOnline: boolean;
  recentActivity: RecentActivity[];
}

export interface MyProfile extends PublicProfile {
  // Additional fields specific to current user's profile
  bio?: string;
  phoneNumber?: string;
  settings: {
    showActive: boolean;
    showLastOnline: boolean;
    receiveFriendRequest: boolean;
    publicProfileInformation: boolean;
  };
}
