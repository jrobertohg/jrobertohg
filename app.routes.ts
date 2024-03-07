import { Routes } from '@angular/router';

export const routes: Routes = [
    {
        path:'dashboard',
        loadComponent:() => import('./dashboard/dashboard.component'),
        children: [
            {
                path: 'inventario',
                title: 'Inventario',
                loadComponent:() => import('./dashboard/pages/inventarios/mostrarInventario.component'),
            },
            {
                path: 'inventario/agregar',
                title: 'Nuevo Inventario',
                loadComponent:() => import('./dashboard/pages/inventarios/agregarInventario.component'),
            },
            {
                path: 'inventario/modificar',
                title: 'Actualizar Inventario',
                loadComponent:() => import('./dashboard/pages/inventarios/modificarInventario.component'),
            },
            {
                path: 'empleado',
                title: 'Empleado',
                loadComponent:() => import('./dashboard/pages/empleados/mostrarEmpleado.component'),
            },
            {
                path: 'empleado/agregar',
                title: 'Nuevo Empleado',
                loadComponent:() => import('./dashboard/pages/empleados/agregarEmpleado.component'),
            },
            {
                path: 'empleado/modificar',
                title: 'Actualizar Empleado',
                loadComponent:() => import('./dashboard/pages/empleados/modificarEmpleado.component'),
            },
            {
                path: 'poliza',
                title: 'Poliza',
                loadComponent:() => import('./dashboard/pages/polizas/mostrarPoliza.component'),
            },
            {
                path: 'poliza/agregar',
                title: 'Nuevo Poliza',
                loadComponent:() => import('./dashboard/pages/polizas/agregarPoliza.component'),
            },
            {
                path: 'poliza/modificar',
                title: 'Actualizar Poliza',
                loadComponent:() => import('./dashboard/pages/polizas/modificarPoliza.component'),
            }
        ]
    }, 
    {
        path: '',
        redirectTo: '/dashboard',
        pathMatch: 'full'
    }

];
