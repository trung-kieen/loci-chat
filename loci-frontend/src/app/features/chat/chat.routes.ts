import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

// features/chat/chat-routing.module.ts
const routes: Routes = [
  {
    path: '',
    loadComponent: () => import('./components/chat-layout/chat-layout')
      .then(m => m.ChatLayout),
    children: [
      {
        path: '', // /chat - empty state (no conversation selected)
        pathMatch: 'full',
        loadComponent: () => import('./components/empty-chat/empty-chat')
          .then(m => m.EmptyChat)
      },
      {
        path: 'one/:id', // /chat/one/123
        loadComponent: () => import('./components/one-to-one-conversation/one-to-one-conversation')
          .then(m => m.OneToOneConversation)
      },
      {
        path: 'group/:id', // /chat/group/456
        loadComponent: () => import('./components/group-conversation/group-conversation')
          .then(m => m.GroupConversation)
      },
      {
        path: 'group/:id/profile', // /chat/group/456/profile
        loadComponent: () => import('./components/group-profile/group-profile')
          .then(m => m.GroupProfile)
      },
      {
        path: 'media/:type/:id', // /chat/media/image/789
        loadComponent: () => import('./components/media-viewer/media-viewer')
          .then(m => m.MediaViewer)
      },
      {
        path: 'create-group', // /chat/create-group
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
