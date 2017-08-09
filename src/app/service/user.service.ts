import { Injectable } from '@angular/core';
//import {HmrState} from 'angular2-hmr';
import { Http, Response, Headers } from '@angular/http';
import 'rxjs/Rx';
/*import {
Http,
Response
} from 'angular2/http';*/

@Injectable()
export class UserService {

    public user: any = [];
    public promise: any;
    public login: number = 0;
    public num: number = 0;
    public url: string = 'http://localhost:9000/'; // localhost

    public isEdited: boolean;
    public changesDone: any;

    constructor(public _http: Http) {
    }

    getUserDetails(userId) {
        this.promise = this._http.get(this.url + 'userprofile/' + userId)
            .map(res => res.json());
        return this.promise;
    }

    getUrl() {
        return this.url;
    }

    setUser(user) {
        this.user = user;
    }

    getUser() {
        return this.user;
    }

    setLogin(num) {
        this.login = num;
    }

    getLogin() {
        return this.login;
    }

    setRefresh(num) {
        this.num = num;
    }

    getRefresh() {
        return this.num;
    }
    setEditedValue(value) {
        this.isEdited = value;
    }
    getEditedValue() {
        return this.isEdited;
    }

}
