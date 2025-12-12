import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'me',
    loadComponent: () => import('./components/personal-profile/personal-profile')
      .then(m => m.PersonalProfile)
  },
  {
    path: 'settings',                         // /user/settings
    loadComponent: () => import('./components/settings/settings')
      .then(m => m.Settings)
  },
  {
    path: 'search',
    loadComponent: () => import('./components/personal-profile/personal-profile')
      .then(m => m.PersonalProfile)
  },
  {
    path: ':id',                              // /user/789  (other user)
    loadComponent: () => import('./components/public-profile/public-profile')
      .then(m => m.PublicProfile)
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserRoutingModule { }

