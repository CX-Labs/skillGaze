import { Injectable } from '@angular/core';
//import {HmrState} from 'angular2-hmr';
import {
  Http,
  Response
} from '@angular/http';
import { UserService } from './service/user.service';

export type InternalStateType = {
  [key: string]: any
};


@Injectable()
export class AppState {
  _state: InternalStateType = {};
  // @HmrState() _state : { [key: string]: any; };
  public _users: any;
  public _user: any;
  public promise: any;
  public promiseUser: any;
  public url: string;

  constructor(public _http: Http, public userService: UserService) {
    this._user = [];
    this.url = this.userService.getUrl();
  }


  // already return a clone of the current state
  get state() {
    return this._state = this._clone(this._state);
  }
  // never allow mutation
  set state(value) {
    throw new Error('do not mutate the `.state` directly');
  }


  get(prop?: any) {
    // use our state getter for the clone
    const state = this.state;
    return state.hasOwnProperty(prop) ? state[prop] : state;
  }

  set(prop: string, value: any) {
    // internally mutate our state
    return this._state[prop] = value;
  }


  private _clone(object: InternalStateType) {
    // simple object clone
    return JSON.parse(JSON.stringify(object));
  }


  // setUsers() {
  //   this.promise = this._http.get(this.url + 'allUsers/');
  // }

  // getUsers() {
  //   return this.promise;
  // }

  // getUser() {
  //   return this._user;
  // }

  // setUser(userName) {
  //   this._http.get(this.url + 'user1/' + userName).subscribe((res) => {
  //     this._user = res.json();
  //   });
  // }

  getLoginUser(email, password) {
    //this.promise = this._http.get(this.url + 'loginUser/' + name + '/' + password).retryWhen(error => error.delay(5000)).timeout(60000, new Error('delay exceeded'));
    this.promise = this._http.get(this.url + 'login/' + email + '/' + password).timeout(5000);
    console.log("this.promise :", this.promise);
    return this.promise;
  }
  // getFbLoginUser(name) {
  //   this.promise = this._http.get(this.url + 'fbloginUser/' + name);
  //   return this.promise;
  // }
}
