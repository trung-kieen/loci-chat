import { Injectable, inject } from '@angular/core';
import { WebApiService } from '../../../core/api/web-api.service';
import { LoggerService } from '../../../core/services/logger.service';
import { delay, EMPTY, Observable, of } from 'rxjs';
import { IUser } from '../../user/models/user.model';
import { IMessage } from '../models/message.model';
import { IPaginationParams } from '../models/chat.model';

// TODO: modification
export interface Conversation {
  id: string;
  name: string;
  avatar: string;
  lastMessage: string;
  lastMessageSender?: string; // Cho group chat
  time: string;
  unreadCount: number;
  isOnline: boolean;
  isGroup: boolean;
  messageStatus?: 'sent' | 'delivered' | 'read';
  isFollowUp?: boolean;
  isArchived?: boolean;
}

@Injectable({
  providedIn: 'root',
})
export class ChatApiService {
  private apiService = inject(WebApiService);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger('ChatApiService');

  getConversations(): Observable<Conversation[]> {
    return of(this.getMockConversations()).pipe(delay(500));
  }

  getConversationById(id: string) {
    const conversation = this.getMockConversations().find((c) => c.id === id);
    if (conversation) {
      return of(conversation).pipe(delay(300));
    }

    return EMPTY;
  }

  updateConversation(id: string, updates: Partial<Conversation>) {
    const conv = this.getMockConversations().find((c) => c.id === id);
    if (conv) {
      Object.assign(conv, updates);
      return of(conv).pipe(delay(300));
    }
    throw new Error('Conversation is not found');
  }
  private getRandomAvatar(): string {
    const seed = Math.random().toString(36).substring(7);
    return `https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=${seed}`;
  }

  getMockConversations(): Conversation[] {
    return [
      {
        id: 'c4338c6b-8480-4864-920a-2112d2dfe73a',
        name: 'Emily Davis',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=7891',
        lastMessage: 'Can we schedule a meeting for tomorrow?',
        time: '3:45 PM',
        unreadCount: 1,
        isOnline: true,
        isGroup: false,
        messageStatus: 'read',
        isFollowUp: false,
        isArchived: false,
      },
      {
        id: 'a1234567-1234-1234-1234-123456789012',
        name: 'John Smith',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=1234',
        lastMessage: 'Hey, how are you doing today?',
        time: '2:30 PM',
        unreadCount: 2,
        isOnline: false,
        isGroup: false,
        messageStatus: 'delivered',
        isFollowUp: false,
        isArchived: false,
      },
      {
        id: 'b2345678-2345-2345-2345-234567890123',
        name: 'Sarah Johnson',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=5678',
        lastMessage: 'Thanks for the update! 👍',
        time: '1:15 PM',
        unreadCount: 0,
        isOnline: true,
        isGroup: false,
        messageStatus: 'read',
        isFollowUp: false,
        isArchived: false,
      },
      {
        id: 'g9876543-9876-9876-9876-987654321098',
        name: 'Marketing Team',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=9876',
        lastMessage: "Let's review the campaign...",
        lastMessageSender: 'Mike',
        time: '12:45 PM',
        unreadCount: 5,
        isOnline: false,
        isGroup: true,
        messageStatus: 'delivered',
        isFollowUp: true,
        isArchived: false,
      },
      {
        id: 'd4321098-4321-4321-4321-432109876543',
        name: 'Alex Chen',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=4321',
        lastMessage: '📎 Document_final.pdf',
        time: '11:30 AM',
        unreadCount: 0,
        isOnline: false,
        isGroup: false,
        messageStatus: 'sent',
        isFollowUp: false,
        isArchived: false,
      },
      {
        id: 'e8765432-8765-8765-8765-876543210987',
        name: 'Lisa Wang',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=8765',
        lastMessage: 'Perfect! See you then.',
        time: 'Yesterday',
        unreadCount: 0,
        isOnline: false,
        isGroup: false,
        messageStatus: 'read',
        isFollowUp: false,
        isArchived: false,
      },
      {
        id: 'f1111111-1111-1111-1111-111111111111',
        name: 'Development Team',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=dev123',
        lastMessage: 'Sprint planning starts at 2 PM',
        lastMessageSender: 'Tom',
        time: 'Yesterday',
        unreadCount: 0,
        isOnline: false,
        isGroup: true,
        messageStatus: 'read',
        isFollowUp: true,
        isArchived: false,
      },
      {
        id: 'g2222222-2222-2222-2222-222222222222',
        name: 'Michael Brown',
        avatar:
          'https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=mike99',
        lastMessage: 'Got it, thanks!',
        time: '2 days ago',
        unreadCount: 0,
        isOnline: true,
        isGroup: false,
        messageStatus: 'read',
        isFollowUp: false,
        isArchived: false,
      },
    ];
  }

  //
  public getCurrentUser(): Observable<IUser> {
    return this.apiService.get<IUser>('/users/me');
  }

  public getUser(userId: string) {
    return this.apiService.get<IUser>(`/users/${userId}`);
  }

  public getMessages(
    conversationId: string,
    pagination: IPaginationParams,
  ): Observable<IMessage[]> {
    return this.apiService.get<IMessage[]>(
      `conversations/${conversationId}/messages`,
      { params: { ...pagination } },
    );
  }
  // public sendMessage(message: ICreateMessage) {}
}
