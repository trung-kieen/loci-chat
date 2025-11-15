import { Component, OnInit, inject } from '@angular/core';
import { WebApiService } from '../../../api/web-api.service';
import { AuthService } from '../../auth/auth.service';

@Component({
  selector: 'app-user-info',
  templateUrl: './user-info.html',
  styleUrl: './user-info.css',
})
export class UserInfo implements OnInit {
  username = 'N/A';

  private authService = inject(AuthService);
  private webApiService = inject(WebApiService);



  async ngOnInit() {
    this.username = await this.authService.getUsername();
    console.log(this.username);

    this.webApiService.getUserInfo().subscribe({

      next: (data) => {
        console.log(data);
        this.username = data.content;
      },
      error: (err) => {
        console.log(err);
      },
    });
  }




  async getUsername() {
    console.log("Call get username");
    this.webApiService.getUserInfo().subscribe({
      next: (data) => {
        console.log(data);
        this.username = data.content;
      },
      error: (err) => {
        console.log(err);
      },
    });

  }
}
