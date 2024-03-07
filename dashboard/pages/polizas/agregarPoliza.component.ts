import { Component, Input } from '@angular/core';
import { CommonModule } from "@angular/common";
import { FormsModule } from "@angular/forms";
import EmpleadoService from '../../../services/empleado.service';
import { Empleado } from '../interfaces/empleado.model';
import { InventarioService } from '../../../services/inventario.service';
import { Inventario } from '../interfaces/inventario.model';
import { PolizaService } from '../../../services/poliza.service';
import { Poliza } from '../interfaces/poliza.model';

@Component({
    selector: 'app-poliza',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './agregarPoliza.component.html',
    styles: '',
})

export default class AgregarPolizaComponent {

    public listaEmpleado: Empleado[] = [];
    public listaInventario: Inventario[] = [];

    @Input() Id: any;
    @Input() NombreCliente: any;
    @Input() Cantidad: any;
    @Input() IdEmpleado: any;
    @Input() Sku: any;
    @Input() mostrarSuccess: any;
    @Input() mostrarWarning: any;


    constructor(
        private polizaService: PolizaService,
        private empleadoService: EmpleadoService,
        private inventarioService: InventarioService
    ) { }

    ngOnInit(): void { 
        this.consultarEmpleado();
        this.consultarInventario();

        this.mostrarSuccess = 'none';
        this.mostrarWarning = 'none';
    }

    consultarEmpleado() {
        const Id = 0;
        this.empleadoService.consultarEmpleado(Id).subscribe(
            response => 
                this.listaEmpleado = response.Data
        )
    }

    changeEmpleado(event: any) {
        const id = event.target.value;
        this.IdEmpleado = id;
    }

    consultarInventario() {
        const sku = 0;
        this.inventarioService.consultarInventario(sku).subscribe(
            response => 
                this.listaInventario = response.Data
        )
    }

    changeInventario(event: any) {
        const id = event.target.value;
        this.Sku = id;
    }

    guardarPoliza(event: any) {
        event.stopPropagation();
        const id = parseInt(this.Id);
        const idEmpleado = parseInt(this.IdEmpleado);
        const sku = parseInt(this.Sku);
        const cantidad = parseInt(this.Cantidad);

        if(id > 0) {
            const poliza: Poliza = { Id: id, NombreCliente: this.NombreCliente, EmpleadoGenero: idEmpleado, Sku: sku, Cantidad: cantidad };
            this.polizaService.guardarPoliza(poliza).subscribe(
                response=> {
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