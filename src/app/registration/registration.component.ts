import { Component } from '@angular/core';
import { HttpModule, Http, Headers } from '@angular/http';
import { Router } from '@angular/router';
import { UserService } from '../service/user.service';
//import { LoaderService } from '../service/loader.service';

declare var $: any;
declare var require: any;

@Component({
  selector: 'registration',
  templateUrl: './registration.component.html'
})

export class Registration {
  public _email: string;
  public _pwd: string;
  public _fullname: string;
  public url: string;
  public _regpassword: string = 'password';
  private bodyPassword: any;
  // private encryptKey: string = "LittleTales";
  // public CryptoJS: any = require('crypto-js');
  //  public AES : any = require("crypto-js/aes");

  constructor(public _router: Router, public userService: UserService, public _http: Http){
    this.url = this.userService.getUrl();
   }

  registerUser(email, fullname, pwd) {    
    // var AES = this.AES;
    // var CryptoJS = this.CryptoJS;

    // this.bodyPassword = CryptoJS.AES.encrypt(pwd, this.encryptKey);
    // let password = this.bodyPassword.toString();
    let isEmailValid = this.validateEmail(email);
    let body = JSON.stringify({ email: email, fullname: fullname, password: pwd});
    if (!isEmailValid || this._email == null || (this._pwd == null) || (this._fullname == null)) {
      let regForm: any = $('.ui.form');
      regForm.form({
        inline: true,
        on: 'blur',
        fields: {
          email: {
            identifier: 'email',
            rules: [
              {
                type: 'empty',
                prompt: 'Please enter an email'
              },
              {
                type: 'email',
                prompt: 'Please enter a valid email'
              }
            ]
          },
          penname: {
            identifier: 'fullname',
            rules: [
              {
                type: 'empty',
                prompt: 'Please enter the full name '
              }
            ]
          },
          password: {
            identifier: 'password',
            rules: [
              {
                type: 'empty',
                prompt: 'Please enter password'
              }
            ]
          },
        }
      })

    } else {
      this.isExistingUser(body, this._email);
    }
  }

  loginPage() {
    this.userService.setRefresh(1);
    this._router.navigate(['/login']);
  }

  validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  }

  showRegModel() {
    let regModal: any = $('#regModel');
    regModal.modal('show');
  }
  showRegSuccessModel() {
    let regSuccessModal: any = $('#regSuccessModel');
    regSuccessModal.modal('show');
  }
  showEmailExistenceModel() {
    let regModel: any = $('#emailExistenceModel');
    regModel.modal('show');
  }

  isExistingUser(body, email) {
    let ths = this;
    // this.loader.showLoader();
     this._http.get(this.url + 'user1/' + email).subscribe((res) => {
       console.log(res.json());
       console.log(res.json().data);
       
       if (res.json().data == null ) {
        let headers = new Headers();
        headers.append('Content-Type', 'application/json');
        // this.loader.showLoader();
        console.log(body);
        this._http.post(this.url + 'reg/', body, { headers: headers })
          .map(response => response.json())
          .subscribe(
          data => {
            // ths.loader.hideLoader();
            console.log('Response is..:' + data);
          },
          err => console.log('Error is..:' + err)
          );
        ths.showRegSuccessModel();
        this.loginPage();
       } else {
        ths.showRegModel();
      }
    });
  }


  togglePasswrd() {
    if (this._regpassword == "password") {
      this._regpassword = "text";
    } else {
      this._regpassword = "password";
    }
  }

}
