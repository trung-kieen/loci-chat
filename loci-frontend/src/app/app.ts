import { Component, inject } from '@angular/core';
import { AuthService } from './core/auth/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.html',
  styleUrl: './app.css',
  standalone: false,
})
export class App {

  protected title = 'loci-frontend';
  private authService = inject(AuthService);
  public logout() {
    this.authService.logout();
  }
}
