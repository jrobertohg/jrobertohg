package entities

type Empleado struct {
	Id         int
	Nombre     string
	Apellido   string
	Puesto     string
	FechaMovto string
}

type ListaEmpleados []Empleado
