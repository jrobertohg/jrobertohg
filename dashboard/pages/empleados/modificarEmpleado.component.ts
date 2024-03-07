import { Component, Input } from '@angular/core';
import { CommonModule } from "@angular/common";
import { FormsModule } from "@angular/forms";
import EmpleadoService from '../../../services/empleado.service';
import { Empleado } from '../interfaces/empleado.model';

@Component({
    selector: 'app-inventario',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './modificarEmpleado.component.html',
    styles: '',
})

export default class ModificarEmpleadoComponent {
    
    @Input() Id: any;
    @Input() Nombre: any;
    @Input() Apellido: any;
    @Input() Puesto: any;
    @Input() mostrarSuccess: any;
    @Input() mostrarWarning: any;

    constructor(
        private empleadoService: EmpleadoService
    ) { }

    ngOnInit(): void { 
        this.mostrarSuccess = 'none';
        this.mostrarWarning = 'none';

        const id = parseInt(localStorage.getItem("Id")?.toString() || "0");
        this.consultarEmpleado(id);
    }

    consultarEmpleado(id: number) {
        this.empleadoService.consultarEmpleado(id).subscribe(
            response => { 
                this.Id = response.Data[0].Id;
                this.Nombre = response.Data[0].Nombre;
                this.Apellido = response.Data[0].Apellido;
                this.Puesto = response.Data[0].Puesto;
            }
        );
    }

    guardarEmpleado(event: any) {
        event.stopPropagation();

        const id = parseInt(this.Id);
        const empleado: Empleado = { Id: id, Nombre: this.Nombre, Apellido: this.Apellido, Puesto: this.Puesto};

        if(id > 0) {
            this.empleadoService.guardarEmpleado(empleado).subscribe(
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