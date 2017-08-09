import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {AppState} from '../app.service';
import {UserService} from '../service/user.service';
//import {LoaderService} from '../service/loader.service';
import {Http, Headers} from '@angular/http';



declare const FB:any;
declare var $:any;


@Component({
    selector: 'facebook',
    templateUrl:'./facebooklogin.component.html'
})

export class Facebook {

 public url : string;
 public responseHolder:string;
 public listHolder:any;
 public username:string;
 public _users:any;
 public _role:string;
 public observe:any;
 public password:any;

    constructor(public _router: Router, public appState: AppState,public _http:Http,public userService: UserService){
     this.url = this.userService.getUrl();
    }



    onFacebookLoginClick() {
      FB.login(function(response) {
    if (response.authResponse) {
     FB.api('/me?fields=id,name,email', function(response) {
      localStorage.setItem("username",response.email);
      localStorage.setItem("password",'fb');
      let password = localStorage.getItem("password");
      this.responseHolder=localStorage.getItem("username");
      let list = JSON.stringify({email:response.email,penname:response.name,password:password,username:response.email,name:response.name,parentid:"parent"});
      localStorage.setItem("list",list);
      this.listHolder= localStorage.getItem("list");
     });
    } else {

    }
}, {scope: 'email'});
this.observe=setInterval(()=>{
  this.getData();
},2000);

    }
    getData(){
      this.responseHolder=localStorage.getItem("username");
      this.listHolder= localStorage.getItem("list");
      if(this.responseHolder!=undefined && this.responseHolder!=""){
        this.isExistingUser(this.listHolder,this.responseHolder);
      }
    }

    isExistingUser(list,email) {
        let ths = this;
        // // this._http.get(this.url+'user1/'+email).subscribe((res) => {
        // //         if(res.json().length == 0) {
        // //           // this.loader.showLoader();
        // //             let headers = new Headers();
        // //             headers.append('Content-Type', 'application/json');
        // //             this._http.post(this.url+'reg/', list, {headers : headers})
        // //                  .map(response => response.json())
        // //                  .subscribe(
        // //                    data =>{
        // //                      ths._users = data;
        // //                      ths.username =  this._users.username;
        // //                      localStorage.setItem("username", ths.username);
        // //                      localStorage.setItem("userid",ths._users._id);
        // //                      this.userService.setUser([ths._users]);
        // //                      localStorage.getItem("username");
        // //                      localStorage.getItem("userid");
        // //                      this.userService.setLogin(1);
        // //                      this.userService.setRefresh(1);
        // //                      this._router.navigate( ['/login'] );
        // //                            },
        // //                    err => console.log('Error is..:' + err)
        // //                  );
        // //             //  this.loader.hideLoader();
        // //         } else {
        // //           // this.loader.showLoader();
        // //           this.username = localStorage.getItem("username");
        // //           this.password = localStorage.getItem("password");
        // //           this.appState.getLoginUser(this.username,this.password)
        // //           .subscribe((res) =>{
        // //             // this.loader.showLoader();
        // //               if(res.json().msg=="user does not exist"){
        // //                 localStorage.setItem("username",'');
        // //                 this.showEmailExistenceModel();
        // //               }else{
        // //                   ths._users = res.json();
        // //                   ths.username =  this._users.username;
        // //                   localStorage.setItem("username", ths.username);
        // //                   localStorage.setItem("userid",ths._users._id);
        // //                   this.userService.setUser([ths._users]);
        // //                   this.userService.setLogin(1);
        // //                   this._router.navigate( ['/login'] );
        // //                   this.userService.setRefresh(1);
        // //               }
        // //         // this.loader.hideLoader();
        // //          },
        // //  err => console.log('Error is..:' + err)

        // //         );
        // //         // this.loader.hideLoader();
        // //         }
        // });

    }

    ngOnInit() {
      }
     ngDoCheck(){
     }

   routerOnDeactivate() {
   this.clearInterval();
    }

    ngOnDestroy() {
     this.clearInterval();
       }

     clearInterval(){
       if(this.observe){
         clearInterval(this.observe);
       }
     }

     showEmailExistenceModel() {
       let regModel: any = $('#emailExistenceModel');
          regModel.modal('show');
   }



}
