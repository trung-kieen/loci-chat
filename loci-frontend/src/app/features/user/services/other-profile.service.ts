import { inject, Injectable, signal } from '@angular/core';
import { ConnectionStatus, PublicProfile } from '../models/other-profile.model';
import { WebApiService } from '../../../api/web-api.service';
import { firstValueFrom, lastValueFrom, Observable, of } from 'rxjs';
@Injectable()
export class OtherProfileService {
  private apiService = inject(WebApiService);
  // Mock data stored in signal
  private mockProfile = signal<PublicProfile>({
    publicId: 'user-7891',
    username: 'emilydavis',
    fullname: 'Emily Davis',
    emailAddress: 'emily.davis@company.com',
    profilePictureUrl: 'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=7891',
    createdAt: new Date('2025-03-15'),
    lastActive: new Date(Date.now() - 5 * 60 * 1000), // 5 minutes ago
    mutualFriendCount: 12,
    connectionStatus: 'not_connected',
    showEmail: true,
    showLastOnline: true,
    recentActivity: [
      {
        id: 'activity-1',
        type: 'message',
        message: 'Sent a message in Marketing Team',
        timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000) // 2 hours ago
      },
      {
        id: 'activity-2',
        type: 'connection',
        message: 'Connected with 3 new colleagues',
        timestamp: new Date(Date.now() - 24 * 60 * 60 * 1000) // 1 day ago
      },
      {
        id: 'activity-3',
        type: 'file',
        message: 'Shared project documents',
        timestamp: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000) // 3 days ago
      }
    ]
  });

  // Additional mock profiles for testing different states
  private mockProfiles: Record<string, PublicProfile> = {
    'friend': {
      publicId: 'user-1234',
      username: 'johnsmith',
      fullname: 'John Smith',
      emailAddress: 'john.smith@company.com',
      profilePictureUrl: 'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=1234',
      createdAt: new Date('2024-11-20'),
      lastActive: new Date(Date.now() - 30 * 60 * 1000),
      mutualFriendCount: 8,
      connectionStatus: 'friend',
      showEmail: true,
      showLastOnline: true,
      recentActivity: [
        {
          id: 'activity-4',
          type: 'message',
          message: 'Replied to your message',
          timestamp: new Date(Date.now() - 30 * 60 * 1000)
        }
      ]
    },
    'request_sent': {
      publicId: 'user-5678',
      username: 'sarahjones',
      fullname: 'Sarah Jones',
      emailAddress: 'sarah.jones@company.com',
      profilePictureUrl: 'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=5678',
      createdAt: new Date('2025-01-10'),
      lastActive: new Date(Date.now() - 2 * 60 * 60 * 1000),
      mutualFriendCount: 5,
      connectionStatus: 'friend_request_sent',
      showEmail: false,
      showLastOnline: true,
      recentActivity: []
    },
    'request_received': {
      publicId: 'user-9012',
      username: 'mikebrown',
      fullname: 'Mike Brown',
      emailAddress: 'mike.brown@company.com',
      profilePictureUrl: 'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=9012',
      createdAt: new Date('2024-12-05'),
      lastActive: new Date(Date.now() - 15 * 60 * 1000),
      mutualFriendCount: 15,
      connectionStatus: 'friend_request_received',
      showEmail: true,
      showLastOnline: true,
      recentActivity: [
        {
          id: 'activity-5',
          type: 'connection',
          message: 'Sent you a friend request',
          timestamp: new Date(Date.now() - 60 * 60 * 1000)
        }
      ]
    },
    'blocked': {
      publicId: 'user-3456',
      username: 'spamuser',
      fullname: 'Blocked User',
      profilePictureUrl: 'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=3456',
      createdAt: new Date('2024-10-01'),
      lastActive: new Date(Date.now() - 48 * 60 * 60 * 1000),
      mutualFriendCount: 0,
      connectionStatus: 'blocked',
      showEmail: false,
      showLastOnline: false,
      recentActivity: []
    }
  };

  /**
   * Get other user's profile (mock data)
   * @param userId Optional user ID to fetch specific profile state
   * @returns UserProfile object
   */
  getOtherProfile(userId: string): Observable<PublicProfile> {

    return this.loadProfile(userId);


    // // If userId provided and exists in mock profiles, return that
    // if (userId && this.mockProfiles[userId]) {
    //   return of(this.mockProfiles[userId]);
    // }

    // // Otherwise return default mock profile
    // return of(this.mockProfile()); // use of function in the rxjs
  }

  get profile() {
    return this.mockProfile.asReadonly();
  }

  updateConnectionStatus(userId: string, status: ConnectionStatus): void {
    // TODO: API call
    this.mockProfile.update(profile => ({
      ...profile,
      connectionStatus: status
    }));
  }

  /**
   * Get all mock profile variants for testing
   */
  getMockProfileVariants(): Record<string, PublicProfile> {
    return this.mockProfiles;
  }

  /**
   * Load profile by user ID (simulates API call)
   * Returns a Promise for async operations
   */
  loadProfile(userId: string): Observable<PublicProfile> {
    return this.apiService.get<PublicProfile>("/users/" + userId);

    // Could throw error for testing error states
    // throw new Error('User not found');

    // return profile;
  }

  /**
   * Send friend request (mock implementation)
   */
  async sendFriendRequest(userId: string): Promise<void> {
    await new Promise(resolve => setTimeout(resolve, 300));
    this.updateConnectionStatus(userId, 'friend_request_sent');
    console.log('Friend request sent to:', userId);
  }

  /**
   * Accept friend request (mock implementation)
   */
  async acceptFriendRequest(userId: string): Promise<void> {
    await new Promise(resolve => setTimeout(resolve, 300));
    this.updateConnectionStatus(userId, 'friend');
    console.log('Friend request accepted from:', userId);
  }

  /**
   * Block user (mock implementation)
   */
  async blockUser(userId: string): Promise<void> {
    await new Promise(resolve => setTimeout(resolve, 300));
    this.updateConnectionStatus(userId, 'blocked');
    console.log('User blocked:', userId);
  }

  /**
   * Unblock user (mock implementation)
   */
  async unblockUser(userId: string): Promise<void> {
    await new Promise(resolve => setTimeout(resolve, 300));
    this.updateConnectionStatus(userId, 'not_connected');
    console.log('User unblocked:', userId);
  }
}
