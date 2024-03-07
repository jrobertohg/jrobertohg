import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from "@angular/common";
import { Router } from '@angular/router';
import EmpleadoService from '../../../services/empleado.service';
import { Empleado } from '../interfaces/empleado.model';

@Component({
    selector: 'app-empleado',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './mostrarEmpleado.component.html',
    styles: ''
})

export default class MostrarEmpleadoComponent {

    public listaEmpleado: Empleado[] = [];
    
    @Input() mostrarModal: String;

    constructor(
        private router: Router,
        private empleadoService: EmpleadoService
    ) { 
        this.mostrarModal = 'none';
    }

    ngOnInit(): void {
        this.consultarEmpleado();
    }

    navegacionAgregar(event: any) {
        event.stopPropagation();
        this.router.navigateByUrl('/dashboard/empleado/agregar')
    }

    consultarEmpleado() {
        const Id = 0;
        this.empleadoService.consultarEmpleado(Id).subscribe(
            response => 
                this.listaEmpleado = response.Data
        )
    }
    
    guardarEmpleado(event: any, Sku: number) {
        event.stopPropagation();
        localStorage.setItem('Id', Sku.toString());
        this.router.navigateByUrl('/dashboard/empleado/modificar');
    }

    mostrarModalEmpleado(event: any, Sku: number) {
        event.stopPropagation();
        this.mostrarModal = 'block';
        localStorage.setItem('Sku', Sku.toString());
    }

    cerrarModal(event: any) {
        event.stopPropagation();
        this.mostrarModal = 'none';
        localStorage.removeItem('Sku');
    }

    eliminarInventario(event: any) {
        event.stopPropagation();

        const id = parseInt(localStorage.getItem("Id")?.toString() || "0");
        if (id > 0) {
            this.empleadoService.eliminarEmpleado(id).subscribe(
                response => {
                    if(response.Meta == "OK") {
                        this.mostrarModal = 'none';
                        this.consultarEmpleado();
                    }
                }
            )
        }
    }
}