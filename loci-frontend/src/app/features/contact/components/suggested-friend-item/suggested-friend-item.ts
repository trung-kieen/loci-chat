import { Component, input, output, signal, inject } from '@angular/core';
import { FriendSuggestion } from '../../models/contact.model';
import { Router } from '@angular/router';
import { LoggerService } from '../../../../core/services/logger.service';

@Component({
  selector: 'app-suggested-friend-item',
  imports: [],
  templateUrl: './suggested-friend-item.html',
  styleUrl: './suggested-friend-item.css',
})
export class SuggestedFriendItem {
  private router = inject(Router);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger("Search Contact Item")

  friend = input.required<FriendSuggestion>();
  addFriend = output<string>();

  protected isSending = signal(false);
  protected requestSent = signal(false);

  onAddFriend(): void {
    if (this.isSending() || this.requestSent()) return;

    this.isSending.set(true);
    this.addFriend.emit(this.friend().userId);
    this.markRequestSent();
  }

  // Called by parent when request is sent
  markRequestSent(): void {
    this.requestSent.set(true);
    this.isSending.set(false);
  }

  navigateToProfile(): void {
    this.logger.info("Naviation to user {} profile", this.friend().userId)
    this.router.navigate(['/user', this.friend().userId]);
  }


}


