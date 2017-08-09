import { Component } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { AppState } from '../app.service';
import { UserService } from '../service/user.service';
//import { LoaderService } from '../service/loader.service';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { Facebook } from '../facebooklogin/facebooklogin.component';
declare var $: any;
declare var require: any;


/*
 * We're loading this component asynchronously
 * We are using some magic with es6-promise-loader that will wrap the module with a Promise
 * see https://github.com/gdi2290/es6-promise-loader for more info
 */
@Component({
  selector: 'login',
  templateUrl: './login.component.html'
})

export class Login {
  public _email: string;
  public _password: string;
  private _users: any;
  public _loginpassword: string = 'password';
  private bodyPassword: any;
  // private encryptKey: string = "skillGaze";
  // public CryptoJS: any = require('crypto-js');
  // public AES : any = require("crypto-js/aes");

  constructor(public _router: Router, public appState: AppState, public userService: UserService) {
  }

  ngOnInit() {
    let email = localStorage.getItem("email");
    let password = localStorage.getItem("password");
    if (email != undefined && email != "" && password != undefined && password != "") {
      this._router.navigate(['/allskills']);
    }
    // this.loader.hideLoader();
  }

  login() {
    let isEmailValid = this.validateEmail(this._email);
    // let AES : any = this.AES;
    // let CryptoJS : any = this.CryptoJS;

    if ((!isEmailValid) || (!this._email && !this._password)) {
      let loginForm: any = $('.ui.form');
      loginForm.form({
        inline: true,
        on: 'blur',
        fields: {
          username: {
            identifier: 'username',
            rules: [
              {
                type: 'empty',
                prompt: 'Please enter a email'
              },
              {
                type: 'email',
                prompt: 'Please enter a valid email'
              }

            ]
          },
          password: {
            identifier: 'password',
            rules: [
              {
                type: 'empty',
                prompt: 'Please enter a password'
              }
            ]
          },

        }
      });

    } else {
      let ths = this;
      // this.loader.showLoader();
      // this.bodyPassword = CryptoJS.AES.encrypt(this._password, this.encryptKey);
      // let password = this.bodyPassword.toString();
      // let enc = encodeURIComponent(password);
      console.log(this._email || this._password);
      this.appState.getLoginUser(this._email, this._password).map(res => res.json())
        .subscribe((res) => {
          console.log(res.data);
          if (res.length == 0) {
            // this.loader.hideLoader();
            ths.showErrorModel();
            return;
          } else {
            ths._users = res.data;
            console.log(ths._users);
            localStorage.setItem("email", this._email);
            localStorage.setItem("password", this._password);
            localStorage.setItem("userid", ths._users.userid);
            ths._email = this._users.email;
            ths._password = this._users.password;
            this.userService.setUser(this._users);
            this._router.navigate(['/allskills']);
            // ths.validate(ths._userName, ths._password);
          }
        }, (err) => {
          // this.loader.hideLoader();
          console.log("error is..." + err);
          ths.showErrorModel();
        }
        );
    }
  }

  register() {
    this._router.navigate(['/registration']);
  }

  forgotPasswrd() {
    this._router.navigate(['/forgot_password']);
  }

  validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  }

  showErrorModel() {
    let errorModal: any = $('#loginModel');
    errorModal.modal('show');
  }
  explore() {
    // this.loader.showLoader();
    this.userService.setRefresh(1);
    this._router.navigate(['/']);
  }

  togglePasswrd() {
    if (this._loginpassword == "password") {
      this._loginpassword = "text";
    } else {
      this._loginpassword = "password"
    }
  }
}
