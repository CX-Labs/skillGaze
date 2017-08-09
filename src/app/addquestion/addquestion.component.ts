
import { Component } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { HttpModule, Http, Headers } from '@angular/http';
import { AppState } from '../app.service';
import { UserService } from '../service/user.service';
import { SkillService } from '../service/skill.service';
import { Router, ActivatedRoute, Params } from '@angular/router';
declare var $: any;

@Component({
  selector: 'addquestion',
  templateUrl: './addquestion.component.html'
})

export class AddQuestion {

   public url: String;
  
  public topicname;
  public qtype;
  public qname;
  public status;
  

//   public saveTop : any = {
//         topicname: '', shortdesc:'', longdesc:''
//          };
  
   
  constructor(public _router: Router,
    public appState: AppState,
    public userService: UserService,
    public skillService: SkillService,
    public _http: Http) {
    this.url = this.userService.getUrl();
  }

  ngOnInit() {
  
  }

  clearForm(){
    this.topicname="";
    this.qname="";
    this.qtype="";
  }

  saveTopic(){
    // this.saveTop.topicname = this.topicname;
    // this.saveTop.shortdesc= this.shortdesc;
    // this.saveTop.longdesc= this.longdesc;
    
    
    // var body = JSON.stringify(this.saveTop);
    // console.log('Body'+body);
    // var headers = new Headers();
    //     headers.append('Content-Type', 'application/json');

    //  this._http.post(this.url + 'newSkill/', body, { headers: headers })
    //       .map(response => response.json())
    //       .subscribe(
    //       data => {
    //         // ths.loader.hideLoader();
    //         console.log('Response is..:' + data.data);
    //          this._router.navigate(['allskills']);
    //       },
    //       err => console.log('Error is..:' + err)
    //       );
          
  }


 
 
}
