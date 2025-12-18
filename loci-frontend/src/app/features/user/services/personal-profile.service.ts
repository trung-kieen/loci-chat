import { inject, Injectable, signal } from '@angular/core';
import { WebApiService } from '../../../core/api/web-api.service';
import {
  PersonalProfile,
  PersonalSettings,
  ProfileUpdateRequest,
  SettingsUpdateRequest,
} from '../models/personal-profile.model';

@Injectable()
export class PersonalProfileService {

  private apiService = inject(WebApiService);

  private _isLoading = signal<boolean>(true);
  private _error = signal<string | null>(null);
  private _profileId = signal<string | null>(null);

  public readonly isLoading = this._isLoading.asReadonly();
  public readonly error = this._error.asReadonly();

  readonly profileId = this._profileId.asReadonly();


  private profileSignal = signal<PersonalProfile | null>(null);
  profile = this.profileSignal.asReadonly();

  private settingsSignal = signal<PersonalSettings | null>(null);
  settings = this.settingsSignal.asReadonly();


  updateSettings(newSettings: Partial<SettingsUpdateRequest>) {
    return this.apiService.patch<PersonalSettings>('/users/me/settings', newSettings).subscribe({
      next: (updated) => this.settingsSignal.set(updated),
    });
  }


  loadMyProfileSettings() {
    this._isLoading.set(true);
    this._error.set(null);
    return this.apiService.get<PersonalSettings>('/users/me/settings').subscribe({
      next: (u) => {
        this.settingsSignal.set(u);
      },
      error: () => {
        this.settingsSignal.set(null);
        this._isLoading.set(false);
        this._error.set('Unable to load profile settings');
      },
      complete: () => this._isLoading.set(false),
    });
  }

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

  updateProfileAvatar(imageFile: File) {
    const formRequest = new FormData();
    formRequest.append("avatar", imageFile);
    return this.apiService.patchForm<PersonalProfile>('/users/me/avatar', formRequest).subscribe({
      next: (updated) => this.profileSignal.set(updated),
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
