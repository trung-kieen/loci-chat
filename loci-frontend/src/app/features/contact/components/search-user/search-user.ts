import { Component, inject, signal } from '@angular/core';
import { FormControl, ReactiveFormsModule } from '@angular/forms';
import { debounceTime, distinctUntilChanged, finalize, switchMap, tap } from 'rxjs';
import { ContactSearchItem } from '../../models/contact.model';
import { SearchUserService } from '../../services/search-user.service';
import { NotificationService } from '../../../../shared/services/notification.service';
import { ContactListItem } from '../contact-list-item/contact-list-item';

@Component({
  selector: 'app-search-user',
  imports: [ReactiveFormsModule, ContactListItem ],
  templateUrl: './search-user.html',
  styleUrl: './search-user.css',
})
export class SearchUser {

  private searchService = inject(SearchUserService);
  private notificationService = inject(NotificationService);

  searchControl = new FormControl('', { nonNullable: true });
  users = signal<ContactSearchItem[]>([]);
  loading = signal(false);

  /* expose a signal that reacts to search text */
  private search$ = this.searchControl.valueChanges.pipe(
    debounceTime(300),
    distinctUntilChanged(),
    tap(() => this.loading.set(true)),
    switchMap(q => this.searchService.search(q).pipe(
      finalize(() => this.loading.set(false))
    ))
  );

  constructor() {

    /* single allowed subscribe (no takeUntil needed) – feeds the signal */

    this.search$.subscribe(res => this.users.set(res.content));

    this.searchService.search(this.searchControl.getRawValue())
      .subscribe({
        next: (u) => this.users.set(u.content),
        complete: () => this.loading.set(false)
      })
  }

  trackById(_: number, u: ContactSearchItem): string { return u.userId; }

  onAddFriend(user: ContactSearchItem): void {
    this.searchService.addFriend(user.userId).subscribe({
      next: () => {
        user.friendshipStatus = 'pending';
        /* re-trigger signal so button flips instantly */
        this.users.set([...this.users()]);



        this.notificationService.success(
          'Friend Request Sent!',
          `Your request has been sent to ${user.fullname}`
        );

      },
      error: () => {
        this.notificationService.error(
          'Request Failed',
          'Unable to send friend request. Please try again.'
        );
      }
    });

  }

}
