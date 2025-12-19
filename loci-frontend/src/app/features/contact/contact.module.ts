import { NgModule } from "@angular/core";
import { ContactRoutingModule } from "./contact.routes";
import { DiscoveryContactService } from "./services/search-contact.service";

@NgModule({
  imports: [ContactRoutingModule],
  providers: [DiscoveryContactService],
})
export class ContactModule {

}
