import { inject, Injectable, signal } from '@angular/core';
import { WebApiService } from '../../../core/api/web-api.service';
import {
  PersonalProfile,
  ProfileUpdateRequest,
} from '../models/personal-profile.model';

@Injectable()
export class PersonalProfileService {
  private _isLoading = signal<boolean>(true);
  private _error = signal<string | null>(null);
  private _profileId = signal<string | null>(null);

  public readonly isLoading = this._isLoading.asReadonly();
  public readonly error = this._error.asReadonly();

  readonly profileId = this._profileId.asReadonly();

  updatePrivacy(arg0: {
    lastSeen: 'Everyone' | 'Contacts Only' | 'Nobody' | null;
    friendRequests: 'Everyone' | 'Nobody' | 'Friends of Friends' | null;
    profileVisibility: boolean | null;
  }) {
    throw new Error('Method not implemented.');
  }

  private apiService = inject(WebApiService);

  private profileSignal = signal<PersonalProfile | null>(null);

  profile = this.profileSignal.asReadonly();

  loadMyProfile() {
    this._isLoading.set(true);
    this._error.set(null);
    return this.apiService.get<PersonalProfile>('/users/me').subscribe({
      next: (u) => {
        this.profileSignal.set(u);
      },
      error: () => {
        this.profileSignal.set(null);
        this._isLoading.set(false);
        this._error.set('Unable to load profile');
      },
      complete: () => this._isLoading.set(false),
    });
  }
  public updateMyProfile(data: Partial<ProfileUpdateRequest>) {
    // this._isLoading.set(true);
    return this.apiService.patch<PersonalProfile>('/users/me', data).subscribe({
      next: (updated) => this.profileSignal.set(updated),
      // complete: () => this._isLoading.set(false),
    });
  }
}
