import { Component, ViewEncapsulation } from '@angular/core';

import { AppState } from './app.service';
// import {LoaderService} from './service/loader.service';
// import { MetaService } from 'ng2-meta';
// import { MetadataService } from 'ng2-metadata';
import { Router, Event, NavigationEnd } from '@angular/router';

declare let ga: Function;

/*
 * App Component
 * Top Level Component
 */


@Component({
  selector: 'app-root',
  encapsulation: ViewEncapsulation.None,
  styleUrls: [
    './app.style.css'
  ],
  template: `
      <main>
      <router-outlet></router-outlet>
    </main>
    `
})
export class AppComponent {
  public title="test title";
  // angularclassLogo = 'assets/img/angularclass-avatar.png';
  // name = 'Angular 2 Webpack Starter';
  // url = 'https://twitter.com/AngularClass';


  constructor(public appState: AppState, public router: Router) {
    //  this.router.events.subscribe(
    //     (event:Event) => {
    //         if (event instanceof NavigationEnd) {
    //             ga('send', 'pageview', event.urlAfterRedirects);
    //         }
    //     });
  }

  ngOnInit() {
    // this.loader.hideLoader();
    // this.appState.setUsers();
  }

}
