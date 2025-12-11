import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { AccessDenied } from './core/components/access-denied/access-denied';
import { NgModule } from '@angular/core';
import { AuthGuard } from './core/auth/auth.guard';
import { Demo } from './shared/components/demo/demo';
import { Logout } from './core/components/logout/logout';

export const appRoutes: Routes = [
  { path: '', redirectTo: '/user/me', pathMatch: 'full' },
  {
    path: 'access-denied',
    component: AccessDenied,
    canActivate: [AuthGuard],
  },
  {
    path: 'demo',
    // loadComponent: () => import("./shared/components/demo/demo").then(m => m.Demo),
    component: Demo,
  },
  // { path: '', redirectTo: 'chat', pathMatch: 'full'},

  {
    path: 'logout',
    loadComponent: () => import("./core/components/logout/logout").then(m => m.Logout),
    // component: Logout,
  },

  {
    path: 'chat',
    loadChildren: () => import("./features/chat/chat.module").then(m => m.ChatModule),
    data: { preload: true }
  },
  {
    path: 'user',
    loadChildren: () => import("./features/user/user.module").then(m => m.UserModule),
  },
  {
    path: 'contact',
    loadChildren: () => import("./features/contact/contact.module").then(m => m.ContactModule),
  },
  {
    path: 'notifications',
    loadChildren: () => import("./features/notification/notification.module").then(m => m.NotificationModule),
  },
  // Fallback
  { path: '**', redirectTo: '/user' }

];

@NgModule({
  imports: [RouterModule.forRoot(appRoutes, {
    preloadingStrategy: PreloadAllModules,
    scrollPositionRestoration: 'enabled',
    anchorScrolling: 'enabled',
    enableTracing: false // true for debugging
  })],
  exports: [RouterModule],
})
export class AppRoutingModule { }
