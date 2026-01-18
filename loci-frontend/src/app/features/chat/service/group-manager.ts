import { Injectable, inject } from '@angular/core';
import {
  IChatReference,
  ICreatedGroupResponse,
  ICreateGroupRequest,
  IGroupMetadata,
  IUpdateGroupProfile,
} from '../../chat/models/chat.model';
import { WebApiService } from '../../../core/api/web-api.service';
import { LoggerService } from '../../../core/services/logger.service';
@Injectable({
  providedIn: 'root',
})
export class GroupManager {
  private apiService = inject(WebApiService);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger('GroupManager');

  createGroupConversation(groupData: ICreateGroupRequest) {
    return this.apiService.post<ICreatedGroupResponse>(
      'conversations/group',
      groupData,
    );
  }

  updateGroupImage(groupId: string, imageFile: File) {
    const formRequest = new FormData();
    formRequest.append('groupProfilePicture', imageFile);
    return this.apiService.patchForm<IGroupMetadata>(
      `groups/${groupId}/image`,
      formRequest,
    );
  }

  updateGroupProfile(groupData: IUpdateGroupProfile) {
    return this.apiService.patch<IGroupMetadata>('groups', groupData);
  }
}
