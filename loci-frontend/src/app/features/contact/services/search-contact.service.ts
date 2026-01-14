import { inject, Injectable } from '@angular/core';
import { WebApiService } from '../../../core/api/web-api.service';
import { Observable } from 'rxjs';
import {
  IFriendSuggestionList,
  IContactProfileList,
} from '../models/contact.model';
import { LoggerService } from '../../../core/services/logger.service';

@Injectable()
export class DiscoveryContactService {
  private apiService = inject(WebApiService);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger('SearchUserService');

  getSuggestions(): Observable<IFriendSuggestionList> {
    return this.apiService.get<IFriendSuggestionList>('/users/suggests');
  }

  search(query: string): Observable<IContactProfileList> {
    this.logger.debug('Query user with ', query);
    // const params = new HttpParams().set('q', query.trim());
    // return this.apiService.get<UserSearchItem[]>('/users', params);
    return this.apiService.get<IContactProfileList>('/users/search?q=' + query);
  }
}
