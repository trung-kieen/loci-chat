import { Component, inject, OnInit, signal } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { ChatApiService, Conversation } from '../../service/chat-api-service';
import { LoggerService } from '../../../../core/services/logger.service';
import { ChatFilter } from '../../models/chat.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-chat-list',
  imports: [CommonModule, RouterModule],
  templateUrl: './chat-list.html',
  styleUrl: './chat-list.css',
})
export class ChatList implements OnInit {
  private router = inject(Router);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger('ChatList');

  conversations = signal<Conversation[]>([]);
  filteredConversations = signal<Conversation[]>([]);
  searchQuery = signal('');
  activeFilter = signal<ChatFilter>('inbox');
  isLoading = signal(true);

  ngOnInit(): void {
    this.loadConversations();
  }

  getConversationRoute(conv: Conversation): string {
    return conv.isGroup ? `/chat/group/${conv.id}` : `/chat/one/${conv.id}`;
  }

  public goToCreateGroup() {
    this.router.navigate(['/chat/create-group']);
  }
  private chatService = inject(ChatApiService);

  loadConversations() {
    this.isLoading.set(true);
    this.chatService.getConversations().subscribe({
      next: (data) => {
        this.conversations.set(data);
        this.applyFilters();
        this.isLoading.set(false);
      },
      error: (err) => {
        this.logger.error('Error loading conversations: ', err);
      },
    });
  }

  onSearch(event: Event) {
    const query = (event.target as HTMLInputElement).value.toLowerCase();
    this.searchQuery.set(query);
    this.applyFilters();
  }

  setFilter(filter: ChatFilter) {
    this.activeFilter.set(filter);
    this.applyFilters();
  }

  applyFilters() {
    let filtered = this.conversations();
    const query = this.searchQuery();
    const filter = this.activeFilter();

    if (query) {
      filtered = filtered.filter((conv) => {
        return (
          conv.name.toLowerCase().includes(query) ||
          conv.lastMessage.toLowerCase().includes(query)
        );
      });
    }
    switch (filter) {
      case 'unread':
        filtered = filtered.filter((conv) => conv.unreadCount > 0);
        break;
      case 'followups':
        filtered = filtered.filter((conv) => conv.isFollowUp);
        break;
      case 'archived':
        filtered = filtered.filter((conv) => conv.isArchived);
        break;
      default: // inbox
        filtered = filtered.filter((conv) => !conv.isArchived);
    }

    this.filteredConversations.set(filtered);
  }
}
