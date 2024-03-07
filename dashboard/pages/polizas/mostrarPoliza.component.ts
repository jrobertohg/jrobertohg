import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from "@angular/common";
import { Router } from '@angular/router';
import { Poliza } from '../interfaces/poliza.model';
import { PolizaService } from '../../../services/poliza.service';

@Component({
    selector: 'app-empleado',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './mostrarPoliza.component.html',
    styles: ''
})

export default class MostrarPolizaComponent {

    public listaPoliza: Poliza[] = [];
    
    @Input() mostrarModal: String;

    constructor(
        private router: Router,
        private polizaService: PolizaService
    ) { 
        this.mostrarModal = 'none';
    }

    ngOnInit(): void {
        this.consultarPoliza();
    }

    navegacionAgregar() {
        this.router.navigateByUrl('/dashboard/poliza/agregar');
    }

    consultarPoliza() {
        const id = 0;
        this.polizaService.consultarPoliza(id).subscribe(
            response => 
                this.listaPoliza = response.Data
        )
    }

    cerrarModal(event: any) {
        event.stopPropagation();
        this.mostrarModal = 'none';
        localStorage.removeItem('Id');
        localStorage.removeItem('Sku');
    }

    mostrarModalPoliza(event: any, Sku: number) {
        event.stopPropagation();
        this.mostrarModal = 'block';
        localStorage.setItem('Id', Sku.toString());
    }

    guardarPoliza(event: any, Id: number, Sku: number) {
        event.stopPropagation();
        localStorage.setItem('Id', Id.toString());
        localStorage.setItem('Sku', Id.toString());
        this.router.navigateByUrl('/dashboard/poliza/modificar');
    }

    eliminarPoliza(event: any) {
        event.stopPropagation();

        const id = parseInt(localStorage.getItem("Id")?.toString() || "0");

        if (id > 0) {
            this.polizaService.eliminarPoliza(id).subscribe(
                response => {
                    if(response.Meta == "OK") {
                        this.mostrarModal = 'none';
                        this.consultarPoliza();
                    }
                }
            )
        }
    }
}