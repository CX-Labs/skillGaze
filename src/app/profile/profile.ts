import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from '../service/user.service';


import { AppState } from '../app.service';


declare var $: any;
declare var require: any;



@Component({
  selector: 'profile',
  styles: [`
h1 {
font-family: Arial, Helvetica, sans-serif
}
`],
  templateUrl: './profile.html'
})

export class Profile {



  constructor(public _router: Router, public appState: AppState, public userService: UserService) {


  }

  ngOnInit() {
  }
}
