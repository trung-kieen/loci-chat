import { NgModule } from "@angular/core";
import { UserRoutingModule } from "./user.routes";
import { PersonalProfileService } from "./services/personal-profile.service";
import { PublicProfileService } from "./services/public-profile.service";

@NgModule({
  imports: [UserRoutingModule],
  providers: [PersonalProfileService, PublicProfileService],
})
export class UserModule {

}
