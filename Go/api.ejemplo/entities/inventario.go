package entities

type Inventario struct {
	Sku                 int
	NombreArticulo      string
	DescripcionArticulo string
	Cantidad            int
	FechaMovto          string
}

type ListaInventarios []Inventario
