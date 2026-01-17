import { signal, inject, computed, Injectable } from '@angular/core';
import { ICreateGroupRequest, IFriend } from '../models/chat.model';
import { toObservable, toSignal } from '@angular/core/rxjs-interop';
import { debounceTime, distinctUntilChanged, map, switchMap } from 'rxjs';
import { FriendManagerService } from '../../contact/services/friend-manager.service';

@Injectable({
  providedIn: 'root',
})
export class CreateGroupService {
  groupName = signal<string>('');
  imageUrl = signal<string | null>(null);
  selectedFriends = signal<IFriend[]>([]);
  searchQuery = signal<string>('');
  friendService = inject(FriendManagerService);

  // facade
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
  addMember(friend: IFriend): void {
    this.selectedFriends.update((members) => [...members, friend]);
  }

  removeMember(friendId: string): void {
    this.selectedFriends.update((members) =>
      members.filter((m) => m.userId !== friendId),
    );
  }

  updateAvatar(url: string): void {
    this.imageUrl.set(url);
  }

  searchFriends(query: string): void {
    this.searchQuery.set(query);
  }

  async createGroup() {
    const groupData: ICreateGroupRequest = {
      groupName: this.groupName(),
      imageUrl: this.imageUrl(),
      memberIds: this.selectedFriends().map((m) => m.userId),
    };

    if (!groupData.groupName.trim()) {
      throw new Error('Group name is required');
    }
    if (groupData.memberIds.length === 0) {
      throw new Error('At least one member is required');
    }

    this.friendService.createGroup(groupData);
    // Mock API call - replace with real implementation
    console.log('Creating group:', groupData);
    // return of(null).pipe(delay(1000)).toPromise();
  }

  updateGroupName(newName: string | null) {
    if (!newName) return;
    this.groupName.set(newName);
  }

  reset(): void {
    this.groupName.set('');
    this.imageUrl.set(null);
    this.selectedFriends.set([]);
    this.searchQuery.set('');
  }
}
