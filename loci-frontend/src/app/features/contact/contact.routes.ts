import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    loadComponent: () =>
      import('./components/search-user/search-user').then(
        (m) => m.SearchUser,
      ),
  },

  {
    path: 'friends', // /contact/friends
    loadComponent: () =>
      import('./components/friend-request/friend-request').then(
        (m) => m.FriendRequest,
      ),
  },
  {
    path: 'blocked', // /contact/blocked
    loadComponent: () =>
      import('./components/block-user-list/block-user-list').then(
        (m) => m.BlockUserList,
      ),
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ContactRoutingModule { }
