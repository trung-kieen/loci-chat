import { Component, input, output, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Notification } from '../../model/notification.model';

@Component({
  selector: 'app-toast-notification',
  imports: [CommonModule],
  templateUrl: './toast-notification.html',
  styleUrl: './toast-notification.css',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class ToastNotification {
  notification = input.required<Notification>();
  dismissed = output<string>();

  readonly iconMap = {
    success: 'fa-check',
    error: 'fa-xmark',
    info: 'fa-info',
    warning: 'fa-exclamation'
  };

  onDismiss(): void {
    this.dismissed.emit(this.notification().id);
  }
}
