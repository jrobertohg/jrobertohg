package service

import (
	"fmt"

	"main.go/entities"
)

func ConsultarInventario(Sku int) entities.ListaInventarios {

	fmt.Println("Inicio InventarioService::ConsultarInventario")

	var listaInventarios = entities.ListaInventarios{}

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return listaInventarios
	}

	defer db.Close()

	//Ejecutar la función de PostgreSQL
	rows, err := db.Query("SELECT sku, nombre_articulo, descripcion_articulo, cantidad, fechamovto FROM FUN_CONSULTARINVENTARIO($1::INTEGER)", Sku)

	if err != nil {

		fmt.Println("Error al preparar el statement a la base de datos", err)

		return listaInventarios
	}

	defer rows.Close()

	// Recorrer los resultados
	for rows.Next() {

		var inventario = entities.Inventario{}

		err := rows.Scan(&inventario.Sku, &inventario.NombreArticulo, &inventario.DescripcionArticulo, &inventario.Cantidad, &inventario.FechaMovto)

		listaInventarios = append(listaInventarios, inventario)

		if err != nil {

			fmt.Println("Error al llamar la funcion y leer los resultados", err)

			return listaInventarios
		}

	}

	fmt.Println("Termina InventarioService::ConsultarInventario")

	return listaInventarios
}

func GuardarInventario(inventario entities.Inventario) int {

	fmt.Println("Inicio InventarioService::GuardarInventario")

	var resultado int = 0

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return resultado
	}

	defer db.Close()

	//Preparar la consulta
	stmt, err := db.Prepare("SELECT FUN_GUARDARINVENTARIO FROM FUN_GUARDARINVENTARIO($1::INTEGER, $2::varchar(50), $3::varchar(50), $4::INTEGER)")

	if err != nil {

		fmt.Println("Error al preparar el statement a la base de datos", err)

		return resultado

	}

	defer stmt.Close()

	//Ejecutar la consulta y obtener los resultados
	err = stmt.QueryRow(inventario.Sku, inventario.NombreArticulo, inventario.DescripcionArticulo, inventario.Cantidad).Scan(&resultado)

	if err != nil {

		fmt.Println("Error al ejecutar la funcion FUN_GUARDARINVENTARIO", err)

		return resultado

	}

	fmt.Println("Resultado:", resultado)

	return resultado
}

func EliminarInventario(Sku int) int {

	fmt.Println("Inicio InventarioService::EliminarInventario")

	var resultado int

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return resultado
	}

	//Preparar la consulta
	stmt, err := db.Prepare("SELECT FUN_ELIMINARINVENTARIO FROM FUN_ELIMINARINVENTARIO($1::INTEGER)")

	if err != nil {

		fmt.Println("Error al preparar el statement a la base de datos", err)

		return resultado

	}

	defer stmt.Close()

	//Ejecutar la consulta y obtener los resultados
	err = stmt.QueryRow(Sku).Scan(&resultado)

	if err != nil {

		fmt.Println("Error al ejecutar la funcion FUN_ELIMINARINVENTARIO", err)

		return resultado

	}

	fmt.Println("Resultado:", resultado)

	return resultado
}
