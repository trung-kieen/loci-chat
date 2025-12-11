import { NgModule } from "@angular/core";
import { ContactRoutingModule } from "./contact.routes";
import { SearchContactService } from "./services/search-contact.service";

@NgModule({
  imports: [ContactRoutingModule],
  providers: [SearchContactService],
})
export class ContactModule {

}
