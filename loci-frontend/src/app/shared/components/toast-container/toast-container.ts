import { CommonModule } from '@angular/common';
import { ToastNotification } from '../toast-notification/toast-notification';
import { Component, inject, ChangeDetectionStrategy } from '@angular/core';
import { NotificationService } from '../../services/notification.service';

@Component({
  selector: 'app-toast-container',
  imports: [CommonModule, ToastNotification],
  templateUrl: './toast-container.html',
  styleUrl: './toast-container.css',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class ToastContainer {

  notificationService = inject(NotificationService);
}
