package entities

type Poliza struct {
	Id             int
	NombreCliente  string
	EmpleadoGenero int
	Empleado       Empleado
	Sku            int
	Inventario     Inventario
	Cantidad       int
	FechaMovto     string
}

type ListaPolizas []Poliza
