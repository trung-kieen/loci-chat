import { Component, inject, input, output, signal } from '@angular/core';
import { IConntectRequested } from '../../../models/contact.model';
import { Router } from '@angular/router';

@Component({
  selector: 'app-friend-request-item',
  imports: [],
  templateUrl: './friend-request-item.html',
  styleUrl: './friend-request-item.css',
})
export class FriendRequestItem {
  private router = inject(Router);
  request = input.required<IConntectRequested>();

  accept = output<string>();
  decline = output<string>();

  protected isProcessing = signal(false);
  protected actionTaken = signal<'accepted' | 'declined' | null>(null);

  onAccept() {
    if (this.isProcessing()) return;
    this.isProcessing.set(true);

    this.accept.emit(this.request().userId);
    this.markActionComplete('accepted');
  }

  onDecline() {
    if (this.isProcessing()) return;
    this.isProcessing.set(true);

    this.decline.emit(this.request().userId);
    this.markActionComplete('declined');
  }

  markActionComplete(action: 'accepted' | 'declined'): void {
    this.actionTaken.set(action);
    this.isProcessing.set(false);
  }

  navigateToProfile(): void {
    this.router.navigate(['/user', this.request().userId]);
  }
}
