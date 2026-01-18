import { signal, inject, computed, Injectable } from '@angular/core';
import {
  IChatReference,
  ICreatedGroupResponse,
  ICreateGroupRequest,
  IFriend,
} from '../models/chat.model';
import { toObservable, toSignal } from '@angular/core/rxjs-interop';
import {
  debounceTime,
  distinctUntilChanged,
  map,
  switchMap,
  catchError,
  of,
  tap,
  Observable,
  EMPTY,
} from 'rxjs';
import { FriendManagerService } from '../../contact/services/friend-manager.service';
import { GroupManager } from './group-manager';
import { LoggerService } from '../../../core/services/logger.service';
import { HttpErrorResponse } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class CreateGroupService {
  // State Signals
  groupName = signal<string>('');
  image = signal<File | null>(null);
  imagePreviewUrl = signal<string | null>(null);
  selectedFriends = signal<IFriend[]>([]);
  searchQuery = signal<string>('');

  // Server error signal
  serverError = signal<string | null>(null);

  // Services
  private friendService = inject(FriendManagerService);
  private groupManagerService = inject(GroupManager);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger('CreateGroupService');

  // Facade for filtered friends
  private filteredFriends$ = toObservable(this.searchQuery).pipe(
    debounceTime(300),
    distinctUntilChanged(),
    switchMap((query) => this.friendService.searchFriend(query)),
    map((friendList) => friendList.friends.content),
  );

  filteredFriends = toSignal(this.filteredFriends$, {
    initialValue: [],
  });

  selectedCount = computed(() => this.selectedFriends().length);

  // Set server error
  setServerError(message: string): void {
    this.serverError.set(message);
  }

  // Clear server error
  clearServerError(): void {
    this.serverError.set(null);
  }

  addMember(friend: IFriend): void {
    if (this.selectedFriends().includes(friend)) return;
    this.selectedFriends.update((members) => [...members, friend]);
  }

  removeMember(friendId: string): void {
    this.selectedFriends.update((members) =>
      members.filter((m) => m.userId !== friendId),
    );
  }

  updateAvatar(url: string): void {
    this.imagePreviewUrl.set(url);
  }

  searchFriends(query: string): void {
    this.searchQuery.set(query);
  }

  //  Remove throwing errors, handle validation in component
  createGroup(): Observable<ICreatedGroupResponse> {
    const groupData: ICreateGroupRequest = {
      groupName: this.groupName(),
      memberIds: this.selectedFriends().map((m) => m.userId),
    };

    this.logger.debug('Create group with request body ', groupData);

    return this.groupManagerService.createGroupConversation(groupData).pipe(
      tap((createdGroup) => {
        this.logger.debug('Group created successfully', createdGroup);

        // Upload group image in separate request
        const imageFile = this.image();
        if (imageFile) {
          this.groupManagerService
            .updateGroupImage(createdGroup.group.groupId, imageFile)
            .pipe(
              catchError((err) => {
                this.logger.error('Failed to upload group image:', err);
                return of(null); // Don't fail the whole operation
              }),
            )
            .subscribe();
        }

        // Clear errors and reset form after successful creation
        this.clearServerError();
        this.reset();
      }),
      catchError((error) => {
        this.logger.error('Failed to create group:', error);

        // Extract user-friendly error message from server response
        const errorMessage = this.extractErrorMessage(error);
        this.setServerError(errorMessage);

        return EMPTY;
      }),
    );
  }

  // Extract user-friendly error message from server response
  private extractErrorMessage(error: unknown): string {
    if (error instanceof HttpErrorResponse) {
      if (error?.error?.message) {
        return error.error.message; // Spring Boot default error format
      }
      if (error?.error?.errors) {
        // Spring Boot validation errors
        return error.error.errors.join(', ');
      }
      if (error?.message) {
        return error.message;
      }
      if (typeof error === 'string') {
        return error;
      }
    }

    return 'An unexpected error occurred. Please try again.';
  }

  updateImageFile(image: File) {
    this.image.set(image);
  }

  // Allow empty strings to clear the name
  updateGroupName(newName: string | null) {
    this.groupName.set(newName ?? '');
  }

  reset(): void {
    this.groupName.set('');
    this.image.set(null);
    this.imagePreviewUrl.set(null);
    this.selectedFriends.set([]);
    this.searchQuery.set('');
    this.clearServerError();
  }
}
