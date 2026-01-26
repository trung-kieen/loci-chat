import { Injectable, inject } from '@angular/core';
import { WebApiService } from '../../../core/api/web-api.service';
import { LoggerService } from '../../../core/services/logger.service';
import { Observable } from 'rxjs';
import { IUser } from '../../user/models/user.model';
import { ICreateMessage, IMessage } from '../models/message.model';
import { PageRequest } from '../../../core/model/page';
import { IPaginationParams } from '../models/chat.model';
@Injectable({
  providedIn: 'root',
})
export class ChatApiService {
  private apiService = inject(WebApiService);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger('ChatApiService');

  //
  public getCurrentUser(): Observable<IUser> {
    return this.apiService.get<IUser>('/users/me');
  }

  public getUser(userId: string) {
    return this.apiService.get<IUser>(`/users/${userId}`);
  }

  public getMessages(
    conversationId: string,
    pagination: IPaginationParams,
  ): Observable<IMessage[]> {
    return this.apiService.get<IMessage[]>(
      `conversations/${conversationId}/messages`,
      { params: { ...pagination } },
    );
  }
  // public sendMessage(message: ICreateMessage) {}
}
