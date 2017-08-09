import { NgModule } from '@angular/core';
import { ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { Login } from './login';
import { AllSkills } from './allskills';
import { AddSkill } from './addskill';
import { AddTopic } from './addtopic';
import { AddQuestion } from './addquestion';
import { MySkills } from './myskills';
import { Profile } from './profile';
import { Registration } from './registration';
import { AppState } from './app.service';


export const appRoutes: Routes = [
  {
    path: '', redirectTo: '/login', pathMatch: 'full',
    data: {
      metadata: {
        title: 'SkillGaze',
        description: 'skillGaze Login'
      }
    }
  },
  {
    path: 'login', component: Login,
    data: {
      meta: {
        title: 'SkillGaze',
      }
    }
  },
  {
    path: 'registration', component: Registration,
    data: {
      metadata: {
        title: 'SkillGaze',
      }
    }
  },
  {
    path: 'allskills', component: AllSkills,
    data: {
      metadata: {
        title: 'SkillGaze',
      }
    }
  },
  {
    path: 'myskills', component: MySkills,
    data: {
      metadata: {
        title: 'SkillGaze',
      }
    }
  },
  {
    path: 'profile', component: Profile,
    data: {
      metadata: {
        title: 'SkillGaze',
      }
    }
  },
  {
    path: 'addskill', component: AddSkill,
    data: {
      metadata: {
        title: 'SkillGaze',
      }
    }
  },
  {
    path: 'addtopic', component: AddTopic,
    data: {
      metadata: {
        title: 'SkillGaze',
      }
    }
  }
  ,
  {
    path: 'addquestion', component: AddQuestion,
    data: {
      metadata: {
        title: 'SkillGaze',
      }
  }
}
  // Async load a component using Webpack's require with es6-promise-loader and webpack `require`
  //{ path: '/about', component:loader: () => require('es6-promise!./about')('About')

];
export const appRoutingProviders: any[] = [
];
export const routing: ModuleWithProviders = RouterModule.forRoot(appRoutes);
@NgModule({
  imports: [RouterModule.forRoot(appRoutes, { useHash: false })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
