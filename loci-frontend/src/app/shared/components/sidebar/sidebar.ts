import { Component, ChangeDetectionStrategy, inject } from '@angular/core';
import { Router } from '@angular/router';
import { KeycloakAuthenticationManager } from '../../../core/auth/keycloak-auth-manager';

// Updated interface to support positioning
interface NavItem {
  label: string;
  icon: string;
  route: string;
  badge?: number;
  badgeColor?: 'primary' | 'accent' | 'warn';
  color?: string;
  tooltip?: string;
  position?: 'top' | 'bottom'; // For sidebar layout
  separator?: boolean; // Show divider above item
}

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.html',
  styleUrl: './sidebar.css',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class Sidebar {
  onSearch() {
    throw new Error('Method not implemented.');
  }
  searchQuery = '';

  menuItems: NavItem[] = [
    // Core Features - Ordered by priority
    {
      label: 'My Profile',
      icon: 'fa-circle-user',
      route: '/user/me',
      tooltip: 'View and edit your profile'
    },
    {
      label: 'Chat',
      icon: 'fa-comments',
      route: '/chat',
      badge: 3, // Unread conversations count from ChatList
      badgeColor: 'primary'
    },
    {
      label: 'Discovery',
      icon: 'fa-address-book',
      route: '/contact',
      tooltip: 'Search contacts'
    },
    {
      label: 'Friend Request',
      icon: 'fa-user-friends',
      route: '/contact/friends',
      tooltip: ''
    },
    // {
    //   label: 'Friends',
    //   icon: 'fa-user-friends',
    //   route: '/contact/friends',
    //   tooltip: 'Manager your friends'
    // },
    {
      label: 'Blocks',
      icon: 'fa-ban',
      route: '/contact/blocked',
      tooltip: 'Manager your blocked'
    },
    {
      label: 'Notifications',
      icon: 'fa-bell',
      route: '/notifications',
      badge: 5, // New notifications count
      badgeColor: 'accent'
    },

    // Secondary Actions - Typically at bottom of sidebar
    {
      label: 'Settings',
      icon: 'fa-gear',
      route: '/user/settings',
      position: 'bottom'
    },
    // {
    //   label: 'Logout',
    //   icon: 'fa-right-from-bracket',
    //   route: '/logout',
    //   color: 'warn',
    //   position: 'bottom',
    //   separator: true // Add visual divider above
    // }
  ];


  private router = inject(Router)
  private authenticationManager = inject(KeycloakAuthenticationManager);

  onLogout(): void {
    // Implement logout logic
    this.authenticationManager.logout();
    this.router.navigate(['/login']);
  }

  trackByRoute(index: number, item: NavItem): string {
    return item.route;
  }
}
