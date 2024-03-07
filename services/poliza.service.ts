import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Poliza } from "../dashboard/pages/interfaces/poliza.model";

@Injectable({
    providedIn: 'root'
})

export class PolizaService  {

    private apiUrl = 'http://localhost:3000';
    private headers =  { headers: new HttpHeaders({ "Content-Type": "application/json" }) };

    constructor(private http: HttpClient) {}

    consultarPoliza(Id: number): Observable<any> {
        const url = `${this.apiUrl}/ConsultarPoliza?sku=${Id}`;
        return this.http.get(url);
    }

    guardarPoliza(poliza: Poliza): Observable<any> {
        const url = `${this.apiUrl}/GuardarPoliza`;
        return this.http.post(url, poliza, this.headers);
    }

    eliminarPoliza(Id: number): Observable<any> {
        const url = `${this.apiUrl}/EliminarInventario?sku=${Id}`;
        return this.http.post(url, this.headers);
    }

}