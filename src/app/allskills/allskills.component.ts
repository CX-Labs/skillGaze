import { Component } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { Http, Response } from '@angular/http';
import { AppState } from '../app.service';
import { UserService } from '../service/user.service';
import { SkillService } from '../service/skill.service';

import { Router, ActivatedRoute, Params } from '@angular/router';
declare var $: any;
@Component({
  selector: 'allskills',
  templateUrl: './allskills.component.html'
})

export class AllSkills {
  
  public pagename = 'allskills';
  public url: string;
  public skills: any[];
  public skill: any;
  public skillName: any;
  public detailsModel: any = {
    skillname: '  ', totalscore: 0, passscore: 0,
    shortdescription: '  ', longdescription: '  '
  };

  constructor(
    public _router: Router,
    public appState: AppState,
    public userService: UserService,
    public skillService: SkillService,
    public _http: Http) {
    this.url = this.userService.getUrl();
  }


  ngOnInit() {
    setTimeout(() => {
      this.getAllSkills();
    }, 1000);
    // document.getElementById("filter").innerHTML = this.pagename;
  }


  getAllSkills() {
    var arr = [];
    this.skillService.getAllSkills().subscribe(
      data => {

        //  Object.keys(data.data).map(x=>arr.push(data.data[x]));//to extract array from response object
        this.skills = data.data;
        console.log(this.skills[0].skillname);

      },
      err => {
        console.log(err);
        // alert('App is unable to connect to our system. Please check your Internet Connection');
        this._router.navigate(['login']);
      });



  }

  getSkillDetails(skill) {
    // this.detailsModel = skill;
    // console.log(skill);
    // this.skillName =$('# sname').val;//document.getElementById('sname').value;
    // console.log(this.skillName);



    history.pushState(null, null, '#/allskills');
    window.addEventListener('popstate', function () {
      history.pushState(null, null, '#/allskills');
    });

    this.skill = skill;
    console.log(this.skill);

    if (this.skill != undefined) {
      this.detailsModel = {
        skillname: this.skill.skillname, totalscore: this.skill.totalscore, passscore: this.skill.passscore,
        shortdescription: this.skill.shortdescription, longdescription: this.skill.longdescription
      };
      console.log(this.detailsModel);

    }


    // let detailsModel: any = $('#detailsModel');
    $('#detailsModel').modal('show');
    // detailsModel.

  }

}