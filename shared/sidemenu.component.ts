import { Component } from '@angular/core';
import { CommonModule } from "@angular/common";
import { routes } from '../app.routes';
import { RouterModule } from '@angular/router';

@Component({
    selector: 'app-sidemenu',
    standalone: true,
    imports: [CommonModule, RouterModule],
    templateUrl: './sidemenu.component.html',
    styles: ''
})

export class SideMenuComponent {

    public menuItems = routes
    .map(
        route => route.children ?? []
    )
    .flat()
    .filter(route => route && route.path)
    .filter(route => !route.path?.includes('/'))

}

const routing = RouterModule.forRoot(routes);