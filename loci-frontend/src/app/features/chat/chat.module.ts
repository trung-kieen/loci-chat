import { NgModule } from "@angular/core";
import { ChatList } from "./components/chat-list/chat-list";
import { CreateGroup } from "./components/create-group/create-group";
import { GroupConversation } from "./components/group-conversation/group-conversation";
import { RouterModule } from "@angular/router";
import { ChatRoutingModule } from "./chat.routes";

@NgModule({
  imports: [ChatRoutingModule]
})
export class ChatModule  {

}
