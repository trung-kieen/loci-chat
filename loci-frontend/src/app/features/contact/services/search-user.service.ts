import { inject, Injectable } from "@angular/core";
import { WebApiService } from "../../../api/web-api.service";
import { Observable } from "rxjs";
import { Page } from "../../../core/model/page";
import { ContactSearchItem } from "../models/contact.model";

@Injectable()
export class SearchUserService {
  private apiService = inject(WebApiService);

  search(query: string): Observable<Page<ContactSearchItem>> {

    // const params = new HttpParams().set('q', query.trim());
    // return this.apiService.get<UserSearchItem[]>('/users', params);
    return this.apiService.get<Page<ContactSearchItem>>("/users/search?q=" + query);
  }


  addFriend(userId: string): Observable<void> {
    return this.apiService.post<void>(`/contacts/${userId}/request`, {});
  }



}
