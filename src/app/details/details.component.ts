import { Component } from '@angular/core';

@Component({
  selector: 'details-page',
  inputs: ['detailsModel'],
  template: require('./details.component.html')
})

export class Details {
  constructor() {

  }
}

