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
  selector: 'addskill',
  templateUrl: './addskill.component.html'
})

export class AddSkill {

  public topics: any[];
  public topic: String;
  public topicId: number;
  public url: String;
  public selTopic = [];
 
  public skillname;
  public shortdesc;
  public longdesc;
  public totalscore=0;
  public passscore=0;
  public duration=0;
  public numberofQs=0;

  public saveTop : any = {
        skillname: '', shortdesc:'', longdesc:'', totalscore:0,  passscore:0, duration:0, numberofQs:0
         };
  
   
  constructor(public _router: Router,
    public appState: AppState,
    public userService: UserService,
    public skillService: SkillService,
    public _http: Http) {
    this.url = this.userService.getUrl();
  }

  ngOnInit() {
    //  $('datalist#optopic').change(this.addTopic($('datalist#optopic').val()));
    //  $("#optopic").bind('select', function () {
    // alert("changed");   
    // });
    setTimeout(() => {
      this.getAllTopics();
    }, 1000);

  }



  addTopic(event) {

    if (this.topic != undefined && (event.keyCode == 13 || event.srcElement.className === 'add circle big icon')) {

      //check if the topic already added to avoid duplicates
      var texists = 'N';

      if (this.selTopic != undefined)
      {
        for (var i = 0; i < this.selTopic.length; i++) {
        if (this.selTopic[i].topicname === this.topic) {
           texists='Y';
           this.topic='';
           break;
        }
      }
      }
      
      if(texists === 'N'){

      //add to array of selected topics
      var element: any = {
        topicid: '', topicname: ''
      };
      
      for (var i = 0; i < this.topics.length; i++) {
        if (this.topics[i] != undefined && this.topics[i].topicname === this.topic) {
          element.topicid = this.topics[i].topicid;
          element.topicname = this.topics[i].topicname;
          this.selTopic.push(element);//push element
          console.log('add element'+this.selTopic[0].topicid);
          console.log('add element'+this.selTopic[0].topicname);
          break;
        }
      }

      var newRowContent = "<tr><td style='padding: 8px; border: 1px solid #dddddd;'>" + this.topic + "</td><td style='padding: 8px; border: 1px solid #dddddd;' contenteditable='true' ></td><td style='padding: 8px; border: 1px solid #dddddd;' contenteditable='true' ></td><td><i class='minus circle icon'></i></td></tr>";
      $(newRowContent).appendTo($("#tblTopics"));
      $('i.minus.circle.icon').on('click', function (event) {
        var tname =$(this).closest('tr').text();
         $(this).closest('tr').remove();
         if(this.selTopic !=undefined){
             for (var i = 0; i < this.selTopic.length; i++) {
               if (this.selTopic[i] != undefined && this.selTopic[i].topicname === tname) {
               this.selTopic.splice(i,1);
                break;
            }
          }
         }
        
        });//attach delete functionality on minus icon 

       
    

       this.topic="";//set to blank once option is selected
      // var top = this.topics.find(checkTopic);

    }
      }
     
    //  console.log(this.selTopic[0].topicname);

  }

  getAllTopics() {
    var arr = [];
    this.skillService.getAllTopics().subscribe(
      data => {
        this.topics = data.data;
        // console.log(this.topics[0].topicname);

      },
      err => {
        console.log(err);
        // alert('App is unable to connect to our system. Please check your Internet Connection');
        this._router.navigate(['allskills']);
      });

  }

  clearForm(){
    this.skillname="";
    this.shortdesc="";
    this.longdesc="";
    this.totalscore=0;
    this.passscore=0;
    this.duration=0;
    this.numberofQs=0;
    $('i.minus.circle.icon').each(function(index){
     $(this).closest('tr').remove();
    });
    this.topic="";

  }

  saveSkill(){
    this.saveTop.skillname = this.skillname;
    this.saveTop.shortdesc= this.shortdesc;
    this.saveTop.longdesc= this.longdesc;
    this.saveTop.totalscore=this.totalscore;
    this.saveTop.passscore=this.passscore;
    this.saveTop.duration= this.duration;
    this.saveTop.numberofQs=this.numberofQs;
    if (this.saveTop != undefined)
    {

    this.saveTop.savtopic=this.getTopicdata(this.selTopic);
   
    }
    
    var body = JSON.stringify(this.saveTop);
    console.log('Body'+body);
    var headers = new Headers();
        headers.append('Content-Type', 'application/json');

     this._http.post(this.url + 'newSkill/', body, { headers: headers })
          .map(response => response.json())
          .subscribe(
          data => {
            // ths.loader.hideLoader();
            console.log('Response is..:' + data.data);
             this._router.navigate(['allskills']);
          },
          err => console.log('Error is..:' + err)
          );
          
  }

getTopicdata(selTopic) { 
var skillTop: any;
  var savTopic =new Array();

var obj = $('#tblTopics tbody tr').map(function() {
var $row = $(this);
var t1 = $row.find(':nth-child(1)').text();
var t2 = $row.find(':nth-child(2)').text();
var t3 = $row.find(':nth-child(3)').text();
var topId=0;
if(t1 !=='Topic Name'){//to skip header

if(selTopic !=undefined){
  for (var i in selTopic) {
  if (selTopic[i].topicname == t1) {
    topId=selTopic[i].topicid; // {a: 5, b: 6}
  }
}
}

 
  skillTop ={
    topicid:topId, topicname :t1, noOfqs :t2, percweight :t3
  };
    savTopic.push(skillTop);
}

});

//  console.log(savTopic);
 return (savTopic);
}
}
