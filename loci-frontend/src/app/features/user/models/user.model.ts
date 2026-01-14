import { FriendshipStatus } from '../../contact/models/contact.model';

export interface IPersonalProfile {
  userId: string;
  firstname: string;
  lastname: string;
  emailAddress: string;
  username: string;
  profilePictureUrl: string;
  activityStatus: boolean;
}

export interface IPersonalSettings {
  lastSeenSetting: 'Everyone' | 'Contacts Only' | 'Nobody';
  friendRequests: 'Everyone' | 'Friends of Friends' | 'Nobody';
  profileVisibility: boolean;
}

// export interface IPublicProfile {
//   publicId: string;
//   fullname: string;
//   username: string;
//   lastname: string;
//   emailAddress: string;
//   profilePictureUrl: string;
// }

export interface IUpdateProfileRequest {
  firstname: string | null;
  lastname: string | null;
  emailAddress: string | null;
  profilePictureUrl: string | null;
  activityStatus: boolean | null;
}

export interface IUpdateSettingsRequest {
  lastSeenSetting: string | null;
  friendRequests: string | null;
  profileVisibility: boolean | null;
}

export interface IUpdatedStatus {
  status: FriendshipStatus;
}

export interface IRecentActivity {
  id: string;
  type: 'message' | 'connection' | 'file' | 'other';
  message: string;
  timestamp: Date;
}

export interface IPublicProfile {
  userId: string;
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
  recentActivity: IRecentActivity[];
}

export interface MyProfile extends IPublicProfile {
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
