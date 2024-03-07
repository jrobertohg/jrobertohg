import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Inventario } from "../dashboard/pages/interfaces/inventario.model";

@Injectable({
    providedIn: 'root'
})

export class InventarioService  {
    
    private apiUrl = 'http://localhost:3000';
    private headers =  { headers: new HttpHeaders({ "Content-Type": "application/json" }) };

    constructor(private http: HttpClient) {}
    
    consultarInventario(Sku: number): Observable<any> {
        const url = `${this.apiUrl}/ConsultarInventario?sku=${Sku}`;
        return this.http.get(url);
    }

    guardarInventario(inventario: Inventario): Observable<any> {
        const url = `${this.apiUrl}/GuardarInventario`;
        return this.http.post(url, inventario, this.headers);
    }

    eliminarInventario(Sku: number): Observable<any> {
        const url = `${this.apiUrl}/EliminarInventario?sku=${Sku}`;
        return this.http.post(url, this.headers);
    }
}