import { inject, Injectable } from '@angular/core';
import { WebApiService } from '../../../core/api/web-api.service';
import { Observable } from 'rxjs';
import { FriendSuggestionList, SearchContactList } from '../models/contact.model';
import { LoggerService } from '../../../core/services/logger.service';

@Injectable()
export class DiscoveryContactService {
  private apiService = inject(WebApiService);
  private loggerService = inject(LoggerService);
  private logger = this.loggerService.getLogger('SearchUserService');


  getSuggestions(): Observable<FriendSuggestionList> {

    return this.apiService.get<FriendSuggestionList>(
      '/users/suggests'
    );
  }

  search(query: string): Observable<SearchContactList> {
    this.logger.debug('Query user with ', query);
    // const params = new HttpParams().set('q', query.trim());
    // return this.apiService.get<UserSearchItem[]>('/users', params);
    return this.apiService.get<SearchContactList>(
      '/users/search?q=' + query,
    );
  }
}
