import { Injectable } from '@angular/core';

import { Http, Response, Headers } from '@angular/http';
import { UserService } from '../service/user.service';
import 'rxjs/Rx';



@Injectable()
export class SkillService {

    public promise: any;
    public url: string;
    public skills: any[];


    constructor(public _http: Http, public userService: UserService) {
        this.url = this.userService.getUrl();
    }


    getAllSkills() {
        this.promise = this._http.get(this.url + 'alldata/')
            .map(res => res.json());
        return this.promise;
    }

    getAllTopics() {
        this.promise = this._http.get(this.url + 'alltopics/')
            .map(res => res.json());
        return this.promise;
    }

    getSkillsOnLoad() {
        return this.skills;
    }

    getMySkills(userId) {
        this.promise = this._http.get(this.url + 'udata/' + userId)
            .map(res => res.json());
        return this.promise;
    }

    getTime(time) {
        let timeStart = new Date(time).getTime();
        let timeEnd = new Date().getTime();
        let hourDiff = timeEnd - timeStart; //in ms
        let secDiff = hourDiff / 1000; //in seconds
        let minDiff = secDiff / 60; //in minutes
        let hDiff = minDiff / 60; //in hours

        let minutes = Math.round(minDiff);
        let hours = Math.round(hDiff);
        let days = Math.floor(hDiff / 24);
        let months = Math.floor(days / 30);
        let years = Math.floor(months / 12);
        if (years >= 1) {
            if (years == 1) {
                return years + " year ago";
            }
            else {
                return years + " years ago";
            }
        } else if (months >= 1) {
            if (months == 1) {
                return months + " month ago";
            }
            else {
                return months + " months ago";
            }
        } else if (days >= 1) {
            if (days == 1) {
                return days + " day ago";
            }
            else {
                return days + " days ago";
            }
        } else if (hours >= 1) {
            if (hours == 1) {
                return hours + " hour ago";
            }
            else {
                return hours + " hours ago";
            }
        } else if (minutes >= 1) {
            if (minutes == 1) {
                return minutes + " minute ago";
            }
            else {
                return minutes + " minutes ago";
            }
        } else {
            return "A few minutes ago";
        }
    }

}
