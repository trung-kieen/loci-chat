import { Component, inject, OnInit } from '@angular/core';
import { CreateGroupService } from '../../service/create-group-service';
import { IFriend } from '../../models/chat.model';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';

@Component({
  selector: 'app-create-group',
  imports: [ReactiveFormsModule],
  templateUrl: './create-group.html',
  styleUrl: './create-group.css',
})
export class CreateGroup implements OnInit {
  private service = inject(CreateGroupService);

  groupName = this.service.groupName;
  imageUrl = this.service.imageUrl;
  selectedFriends = this.service.selectedFriends;
  filteredFriends = this.service.filteredFriends;
  searchQuery = this.service.searchQuery;
  selectedCount = this.service.selectedCount;

  searchControl = new FormControl('', { nonNullable: true });
  groupNameControl = new FormControl('', { nonNullable: true });

  // onGroupNameChange(name: string): void {
  //   this.service.updateGroupName(name);
  // }

  private fb = inject(FormBuilder);
  groupForm: FormGroup = this.fb.group({
    groupName: ['', [Validators.required, Validators.minLength(3)]],
  });

  ngOnInit() {
    this.groupForm.get('groupName')?.valueChanges.subscribe((value) => {
      this.service.updateGroupName(value);
    });
  }

  onSearchFriends(query: string): void {
    this.service.searchFriends(query);
  }

  addMember(friend: IFriend): void {
    this.service.addMember(friend);
  }

  removeMember(friendId: string): void {
    this.service.removeMember(friendId);
  }

  onAvatarSelected(event: Event): void {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.service.updateAvatar(e.target?.result as string);
      };
      reader.readAsDataURL(file);
    }
  }
  async onCreateGroup(): Promise<void> {
    if (this.groupForm.invalid) {
      this.groupForm.markAllAsTouched();
      return;
    }

    try {
      await this.service.createGroup();
      console.log('Group created successfully');
      this.groupForm.reset();
      this.service.reset();
    } catch (error) {
      console.error('Failed to create group:', error);
    }
  }

  onCancel(): void {
    this.groupForm.reset();
    this.service.reset();
  }

  onBack(): void {
    // Navigate back
  }
}
