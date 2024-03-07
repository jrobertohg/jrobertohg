import { Component, Input } from '@angular/core';
import { CommonModule } from "@angular/common";
import { InventarioService } from '../../../services/inventario.service';
import { FormsModule } from '@angular/forms';
import { Inventario } from '../interfaces/inventario.model';

@Component({
    selector: 'app-inventario',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './modificarInventario.component.html',
    styles: ''
})

export default class ModificarInventarioComponent {

    @Input() Sku: any;
    @Input() NombreArticulo: any;
    @Input() DescripcionArticulo: any;
    @Input() Cantidad: any;
    @Input() mostrarSuccess: any;
    @Input() mostrarWarning: any;

    constructor(
        private inventarioService: InventarioService
    ) {  }

    ngOnInit(): void {
        this.mostrarSuccess = 'none';
        this.mostrarWarning = 'none';

        const Sku = parseInt(localStorage.getItem("Sku")?.toString() || "0");
        this.consultarInventario(Sku);
    }

    consultarInventario(Sku: number) {
        this.inventarioService.consultarInventario(Sku).subscribe(
                response => { 
                    this.Sku = response.Data[0].Sku;
                    this.NombreArticulo = response.Data[0].NombreArticulo;
                    this.DescripcionArticulo = response.Data[0].DescripcionArticulo;
                    this.Cantidad = response.Data[0].Cantidad;
                }
        )
    }

    guardarInventario(event: any) {
        event.preventDefault();
        const sku = parseInt(this.Sku);
        const cantidad = parseInt(this.Cantidad);

        const inventario: Inventario = { Sku: sku, NombreArticulo: this.NombreArticulo, DescripcionArticulo: this.DescripcionArticulo, Cantidad: cantidad};
        if (this.Sku > 0) {
            this.inventarioService.guardarInventario(inventario).subscribe(
                response => {
                    if(response.Meta == "OK") {
                        this.mostrarSuccess = 'block';
                        setTimeout(() => {
                            this.mostrarSuccess = 'none';
                        }, 1000);
                    }
                }
            )
        } else {
            this.mostrarWarning = 'block';
            setTimeout(() => {
                this.mostrarWarning = 'none';
            }, 1000);
        }
    }
}