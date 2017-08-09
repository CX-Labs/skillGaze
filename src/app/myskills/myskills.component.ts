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
  selector: 'myskills',
  templateUrl: './myskills.component.html'
})

export class MySkills {

 public url: string;
 public skills : any[];
 public skill: any;
  public skillName: any;
  public detailsModel: any = {
    skillname: '  ', totalscore: 0, passscore: 0,
    shortdescription: '  ', longdescription: '  '
  };
 private user : any[];

 constructor(
   public _router: Router, 
   public appState: AppState, 
   public userService: UserService,
   public skillService: SkillService,
   public _http: Http){
     this.url = this.userService.getUrl();
     this.user = this.userService.getUser();
  }


 ngOnInit() {
    setTimeout(() => {
        this.getMySkills();
        }, 1000);
  
}


getMySkills()
{
  var userId : any;
  console.log(this.user);
  if (this.user == undefined || this.user== null)
   userId = this.user[0].userId;
   else
    userId = localStorage.getItem("userid");
    console.log(userId);

   this.skillService.getMySkills(userId).subscribe(
      data => {
             
        //  Object.keys(data.data).map(x=>arr.push(data.data[x]));//to extract array from response object
         this.skills = data.data;
         console.log(this.skills[0].skillname);

          },
      err => {
        console.log(err);
        // alert('App is unable to connect to our system. Please check your Internet Connection');
        this._router.navigate(['allskillss']);
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