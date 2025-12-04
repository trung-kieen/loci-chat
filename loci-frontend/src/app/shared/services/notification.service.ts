import { Injectable, signal } from '@angular/core';
import { v4 as uuidv4 } from 'uuid';
import { Notification } from '../model/notification.model';

@Injectable()
export class NotificationService {
  private _notifications = signal<Notification[]>([]);
  readonly notifications = this._notifications.asReadonly();

  show(config: Omit<Notification, 'id' | 'show'>): void {
    const id = uuidv4();
    const notification: Notification = { ...config, id, show: false };

    this._notifications.update(n => [...n, notification]);

    // Trigger enter animation
    setTimeout(() => this.updateVisibility(id, true), 10);

    if (config.duration > 0) {
      setTimeout(() => this.dismiss(id), config.duration);
    }
  }

  success(title: string, message?: string, duration = 3000): void {
    this.show({ type: 'success', title, message, duration });
  }

  error(title: string, message?: string, duration = 5000): void {
    this.show({ type: 'error', title, message, duration });
  }

  dismiss(id: string): void {
    this.updateVisibility(id, false);
    setTimeout(() => {
      this._notifications.update(n => n.filter(item => item.id !== id));
    }, 300);
  }

  private updateVisibility(id: string, show: boolean): void {
    this._notifications.update(n =>
      n.map(item => item.id === id ? { ...item, show } : item)
    );
  }
}
