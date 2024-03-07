import { Component, EnvironmentInjector, Input, OnInit } from '@angular/core';
import { CommonModule } from "@angular/common";
import { Router } from '@angular/router';
import { InventarioService } from '../../../services/inventario.service';
import { Inventario } from '../interfaces/inventario.model';

@Component({
    selector: 'app-inventario',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './mostrarInventario.component.html',
    styles: ''
})

export default class MostrarInventarioComponent {

    public listaInventario: Inventario[] = [];
    
    @Input() mostrarModal: String;

    constructor(
        private router: Router, 
        private inventarioService: InventarioService
    ) { 
        this.mostrarModal = 'none';
    }

    ngOnInit(): void {
        this.consultarInventario();
    }

    navegacionAgregar(event: any) {
        event.stopPropagation();
        this.router.navigateByUrl('/dashboard/inventario/agregar');
    }

    consultarInventario() {
        const sku = 0;
        this.inventarioService.consultarInventario(sku).subscribe(
            response => 
                this.listaInventario = response.Data
        )
    }
    
    guardarInventario(event: any, Sku: number) {
        event.stopPropagation();
        localStorage.setItem('Sku', Sku.toString());
        this.router.navigateByUrl('/dashboard/inventario/modificar');
    }

    cerrarModal(event: any) {
        event.stopPropagation();
        this.mostrarModal = 'none';
        localStorage.removeItem('Sku');
    }

    mostrarModalInventario(event: any, Sku: number) {
        event.stopPropagation();
        this.mostrarModal = 'block';
        localStorage.setItem('Sku', Sku.toString());
    }

    eliminarInventario(event: any) {
        event.stopPropagation();
        const sku = parseInt(localStorage.getItem("Sku")?.toString() || "0");

        if (sku > 0) {
            this.inventarioService.eliminarInventario(sku).subscribe(
                response => {
                    if(response.Meta == "OK") {
                        this.mostrarModal = 'none';
                        this.consultarInventario();
                    }
                }
            )
        }
    }
}