import { Component, Input } from '@angular/core';
import { CommonModule } from "@angular/common";
import { Inventario } from '../interfaces/inventario.model';
import { InventarioService } from '../../../services/inventario.service';
import { FormsModule } from '@angular/forms';

@Component({
    selector: 'app-inventario',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './agregarInventario.component.html',
    styles: '',
})

export default class AgregarInventarioComponent {

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
    }

    guardarInventario(event: any) {
        event.stopPropagation();
        const sku = parseInt(this.Sku);
        const cantidad = parseInt(this.Cantidad);
        
        if(sku > 0) {
            const inventario: Inventario = { Sku: sku, NombreArticulo: this.NombreArticulo, DescripcionArticulo: this.DescripcionArticulo, Cantidad: cantidad };

            this.inventarioService.guardarInventario(inventario).subscribe(
                response => {
                    if(response.Meta == "OK") {
                        this.Sku = 0;
                        this.NombreArticulo = '';
                        this.DescripcionArticulo = '';
                        this.Cantidad = 0;
                        
                        this.mostrarSuccess = 'block';
                        setTimeout(() => {
                            this.mostrarSuccess = 'none';
                        }, 1000);
                    }
                }
            )
        } else {
            this.Sku = 0;
            this.NombreArticulo = '';
            this.DescripcionArticulo = '';
            this.Cantidad = 0;
            
            this.mostrarWarning = 'block';
            setTimeout(() => {
                this.mostrarWarning = 'none';
            }, 1000);
        }
    }
}