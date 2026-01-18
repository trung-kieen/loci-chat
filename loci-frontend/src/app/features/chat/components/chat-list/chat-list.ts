import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-chat-list',
  imports: [],
  templateUrl: './chat-list.html',
  styleUrl: './chat-list.css',
})
export class ChatList {
  private router = inject(Router);

  public goToCreateGroup() {
    this.router.navigate(['/chat/create-group']);
  }
}
