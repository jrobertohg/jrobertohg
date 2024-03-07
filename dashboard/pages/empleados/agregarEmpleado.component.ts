import { Component, Input } from '@angular/core';
import { CommonModule } from "@angular/common";
import { FormsModule } from '@angular/forms';
import { Empleado } from '../interfaces/empleado.model';
import EmpleadoService from '../../../services/empleado.service';

@Component({
    selector: 'app-empleado',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './agregarEmpleado.component.html',
    styles: '',
    
})

export default class AgregarEmpleadoComponent {

    @Input() Id: any;
    @Input() Nombre: any;
    @Input() Apellido: any;
    @Input() Puesto: any;
    @Input() mostrarSuccess: any;
    @Input() mostrarWarning: any;

    constructor( 
        private empleadoService: EmpleadoService
    ) {  }

    ngOnInit(): void { 
        this.mostrarSuccess = 'none';
        this.mostrarWarning = 'none';
    }

    guardarEmpleado(event: any) {
        event.stopPropagation();
        const id = parseInt(this.Id);

        const empleado: Empleado = { Id: id,  Nombre: this.Nombre, Apellido: this.Apellido, Puesto: this.Puesto }; 

        if (id > 0) {
            this.empleadoService.guardarEmpleado(empleado).subscribe( 
                response => {
                    if(response.Meta == "OK") {
                        this.Id = 0;
                        this.Nombre = '';
                        this.Apellido = '';
                        this.Puesto = '';
            
                        this.mostrarSuccess = 'block';
                        setTimeout(() => {
                            this.mostrarSuccess = 'none';
                        }, 1000);
                    }
            })
        } else {
            this.Id = 0;
            this.Nombre = '';
            this.Apellido = '';
            this.Puesto = '';

            this.mostrarWarning = 'block';
            setTimeout(() => {
                this.mostrarWarning = 'none';
            }, 1000);
        }
    }
}