import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { LocationStrategy, APP_BASE_HREF, PathLocationStrategy, HashLocationStrategy } from '@angular/common';
import {
  AppRoutingModule,
  appRoutingProviders
} from './app.routing';

import { Login } from './login';
import { Registration } from './registration/registration.component';
import { SkillMenu } from './skillmenu';
import { AllSkills } from './allskills';
import { AddSkill } from './addskill';
import { AddTopic } from './addtopic';
import { AddQuestion } from './addquestion';
import { MySkills } from './myskills';
import { Details } from './details';
import { Profile } from './profile';
import { UserService } from './service/user.service';
import { SkillService } from './service/skill.service';

import { APP_RESOLVER_PROVIDERS } from './app.resolver';
import { AppState, InternalStateType } from './app.service';
import { AppComponent } from './app.component';


// Application wide providers
const APP_PROVIDERS = [
  ...APP_RESOLVER_PROVIDERS,
  AppState
];

type StoreType = {
  state: InternalStateType,
  restoreInputValues: () => void,
  disposeOldHosts: () => void
};

@NgModule({
  declarations: [
    AppComponent,
    Login,
    Registration,
    AllSkills,
    MySkills,
    SkillMenu,
    AddSkill,
    AddTopic,
    AddQuestion,
    Details,
    Profile
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutingModule
  ],
  providers: [
    APP_PROVIDERS,
    UserService,
    SkillService,
    appRoutingProviders,
    { provide: LocationStrategy, useClass: HashLocationStrategy },
    { provide: APP_BASE_HREF, useValue: '!' }],
  bootstrap: [AppComponent]
})
export class AppModule { }
