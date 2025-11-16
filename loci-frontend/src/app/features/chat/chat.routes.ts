import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
{
    path: '',                                   // /chat
    loadComponent: () => import('./components/chat-list/chat-list')
                     .then(m => m.ChatList),
    children: [
      {
        path: 'one/:id',                       // /chat/one/123
        loadComponent: () => import('./components/one-to-one-conversation/one-to-one-conversation')
                         .then(m => m.OneToOneConversation)

      },
      {
        path: 'group/:id',                     // /chat/group/456
        loadComponent: () => import('./components/group-conversation/group-conversation')
                         .then(m => m.GroupConversation)
      },
      {
        path: 'group/:id/profile',             // /chat/group/456/profile
        loadComponent: () => import('./components/group-profile/group-profile')
                         .then(m => m.GroupProfile)
      },
      {
        path: 'media/:type/:id',               // /chat/media/image/789
        loadComponent: () => import('./components/media-viewer/media-viewer')
                         .then(m => m.MediaViewer)
      },
      {
        path: 'create-group',                  // /chat/create-group
        loadComponent: () => import('./components/create-group/create-group')
                         .then(m => m.CreateGroup)
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ChatRoutingModule { }
