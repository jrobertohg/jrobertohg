import { Empleado } from "./empleado.model";
import { Inventario } from "./inventario.model";

export interface Poliza {
    Id: number,
    NombreCliente: string,
    EmpleadoGenero: number,
    Empleado?: Empleado,
    Sku: number,
    Inventario?: Inventario,
    Cantidad: number
}