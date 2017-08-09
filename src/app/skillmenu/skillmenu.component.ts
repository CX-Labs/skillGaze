import { Component, Input, Output } from '@angular/core';
import { Router } from '@angular/router';

import { UserService } from '../service/user.service';

declare var $: any;

@Component({
  selector: 'skillmenu',
  templateUrl: './skillmenu.component.html'
})
export class SkillMenu {
  @Input() pagename: string = '';
  public user: any;
  public role: string;
  public filter: string;

  constructor(public _router: Router, public userService: UserService) {
    // this.activ = this.storyService.getToggling();
  }

  ngOnInit() {
    this.user = this.userService.getUser();
    if (this.user == [] || this.user == '') {
      var userId = localStorage.getItem("userid");
      if (userId != "undefined") {
        this.userService.getUserDetails(userId).subscribe((res) => {
          this.user = res.data;
          this.userService.setUser(this.user);
          this.role = this.user.role;

        });
      }
    }
  }

  getSkills() {
    let allskills: any = $('#allskills');
    $('div.ui.vertical.menu a').removeClass('active teal item').addClass('item');
    allskills.addClass('active teal item');
    this._router.navigate(['/allskills']);
  }

  getMySkills() {
    let myskills: any = $('#myskills');
    $('div.ui.vertical.menu a').removeClass('active teal item').addClass('item');
    myskills.addClass('active teal item');
    this._router.navigate(['/myskills']);
  }

  getMyProfile() {
    let profile: any = $('#profile');
    $('div.ui.vertical.menu a').removeClass('active teal item').addClass('item');
    profile.addClass('active teal item');
    this._router.navigate(['/profile']);
  }

  addNewSkill() {
    let allskills: any = $('#newskill');
    $('div.ui.vertical.menu a').removeClass('active teal item').addClass('item');
    allskills.addClass('active teal item');
    this._router.navigate(['/allskills']);
  }

  getFilterData(action) {
    console.log(action);
    if (action === 'addSkill') {
      this.filter = 'addSkill';
      this._router.navigate(['/addskill']);
    }
    else if (action === 'addTopic') {
      this.filter = 'addTopic';
      this._router.navigate(['/addtopic']);
    }
    else if (action === 'addQues') {
      this.filter = 'addQues';
      this._router.navigate(['/addquestion']);
    }
  }

}
