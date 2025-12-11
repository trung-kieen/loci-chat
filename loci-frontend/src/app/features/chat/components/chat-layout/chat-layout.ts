import { Component } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { ChatList } from '../chat-list/chat-list';

@Component({
  selector: 'app-chat-layout',
  imports: [RouterOutlet, ChatList],
  templateUrl: './chat-layout.html',
  styleUrl: './chat-layout.css',
})
export class ChatLayout {

}
