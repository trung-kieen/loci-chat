import { Component, input, output } from '@angular/core';
import { ContactSearchItem } from '../../models/contact.model';

@Component({
  selector: 'app-contact-list-item',
  imports: [],
  templateUrl: './contact-list-item.html',
  styleUrl: './contact-list-item.css',
})
export class ContactListItem {
  user = input.required<ContactSearchItem>();
  addFriend = output<ContactSearchItem>();

  onAddFriend(): void {
    if (this.user().friendshipStatus === 'none') {
      this.addFriend.emit(this.user());
    }
  }

}
