import { Component, effect, inject, OnInit, OnDestroy, signal } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { debounceTime, merge, Subject, takeUntil } from 'rxjs';
import { PersonalProfileService } from '../../services/personal-profile.service';

@Component({
  selector: 'app-personal-profile',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './personal-profile.html',
  styleUrl: './personal-profile.css',
})
export class PersonalProfile implements OnInit, OnDestroy {
  private profileService = inject(PersonalProfileService);
  private profile = this.profileService.profile;
  private destroy$ = new Subject<void>();

  // public isLoading = signal<boolean>(true);
  // public error = signal<string | null> (null);
  readonly isLoading = this.profileService.isLoading;
  readonly error = this.profileService.error;
  readonly settings = this.profileService.settings;

  public profileForm = new FormGroup({
    firstname: new FormControl(''),
    lastname: new FormControl(''),
    username: new FormControl({ value: '', disabled: true }),
    emailAddress: new FormControl({ value: '', disabled: true }),
    profilePictureUrl: new FormControl(''),

    activityStatus: new FormControl(false),

  });
  public settingForm = new FormGroup({
    lastSeenSetting: new FormControl<'Everyone' | 'Contacts Only' | 'Nobody'>('Everyone'),
    friendRequests: new FormControl<'Everyone' | 'Friends of Friends' | 'Nobody'>('Everyone'),
    profileVisibility: new FormControl(true),
  });







  constructor() {
    effect(() => {
      const p = this.profile();
      const s = this.settings();
      if (!p) return;
      this.profileForm.patchValue({
        firstname: p.firstname,
        lastname: p.lastname,
        emailAddress: p.emailAddress,
        profilePictureUrl: p.profilePictureUrl,
        activityStatus: p.activityStatus,

      })
      if (!s) return;
      this.settingForm.patchValue({

        lastSeenSetting: s.lastSeenSetting,
        friendRequests: s.friendRequests,
        profileVisibility: s.profileVisibility,
      })
    })
  }
  public loadProfile() {
    this.profileService.loadMyProfile();
    this.profileService.loadMyProfile();
  }
  ngOnInit(): void {
    this.profileService.loadMyProfile();
    this.profileService.loadMyProfileSettings();
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  public saveSettings() {
    const settingRaw = this.settingForm.getRawValue();
    if (!settingRaw) return;
    this.profileService.updateSettings(settingRaw);
  }


  public save() {
    const profileRaw = this.profileForm.getRawValue()
    if (!profileRaw) return;
    this.profileService.updateMyProfile(profileRaw);
  }


}
