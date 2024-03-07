import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Empleado } from "../dashboard/pages/interfaces/empleado.model";

@Injectable({
    providedIn: 'root'
})

export default class EmpleadoService  {

    private apiUrl = 'http://localhost:3000';
    private headers =  { headers: new HttpHeaders({ "Content-Type": "application/json" }) };

    constructor(private http: HttpClient) {}
    
    consultarEmpleado(Id: number): Observable<any>  {
        const url = `${this.apiUrl}/ConsultarEmpleado?sku=${Id}`;
        return this.http.get(url);
    }

    guardarEmpleado(empleado: Empleado): Observable<any> {
        const url = `${this.apiUrl}/GuardarEmpleado`;
        return this.http.post(url, empleado, this.headers);
    }

    eliminarEmpleado(Id: number): Observable<any> {
        const url = `${this.apiUrl}/EliminarEmpleado?sku=${Id}`;
        return this.http.post(url, this.headers);
    }
}