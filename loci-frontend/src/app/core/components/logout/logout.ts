import { Component, inject, OnInit } from '@angular/core';
import { KeycloakAuthenticationManager } from '../../auth/keycloak-auth-manager';
import { LoggerService } from '../../services/logger.service';
import { SharedModule } from '../../../shared/shared.module';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-logout',
  standalone: true,
  imports: [SharedModule],
  templateUrl: './logout.html',
  styleUrl: './logout.css',
})
export class Logout implements OnInit {
  private auth = inject(KeycloakAuthenticationManager);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger("Logout");
  // private router = inject(Router);
  ngOnInit(): void {
    this.logger.info("On init the logout page");
    this.auth.logout();
  }


}
