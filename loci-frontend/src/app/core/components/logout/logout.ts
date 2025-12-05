import { Component, inject, OnInit } from '@angular/core';
import { KeycloakAuthenticationManager } from '../../auth/keycloak-auth-manager';
import { Router } from '@angular/router';

@Component({
  selector: 'app-logout',
  imports: [],
  templateUrl: './logout.html',
  styleUrl: './logout.css',
})
export class Logout implements OnInit {
  private auth = inject(KeycloakAuthenticationManager);
  private router = inject(Router);
  ngOnInit(): void {
    this.auth.logout();
  }


}
