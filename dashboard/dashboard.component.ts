import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { SideMenuComponent } from '@shared/sidemenu.component';

@Component({
    standalone: true,
    templateUrl: './dashboard.component.html',
    styles: '',
    imports: [RouterModule, SideMenuComponent]
})

export default class DashboardComponent {

}