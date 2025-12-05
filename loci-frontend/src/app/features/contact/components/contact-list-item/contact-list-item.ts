import { Component, inject, input, output } from '@angular/core';
import { ContactSearchItem } from '../../models/contact.model';
import { Router } from '@angular/router';
import { LoggerService } from '../../../../core/services/logger.service';

@Component({
  selector: 'app-contact-list-item',
  imports: [],
  templateUrl: './contact-list-item.html',
  styleUrl: './contact-list-item.css',
})
export class ContactListItem {
  private router = inject(Router);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger("Search Contact Item")
  user = input.required<ContactSearchItem>();

  addFriend = output<ContactSearchItem>();

  onAddFriend(): void {
    this.logger.info("Add friend user {}", this.user())
    if (this.user().friendshipStatus === 'not_connected') {
      this.addFriend.emit(this.user());
    }
  }

  onAcceptRequest(): void {
    this.logger.info("Accept friend request from user {}", this.user())
    // TODO: Implement accept request logic
    console.log('Accept friend request from:', this.user().userId);
  }


  navigateToProfile(): void {
    this.logger.info("Naviation to user {} profile", this.user())
    this.router.navigate(['/user', this.user().userId]);
  }

}
