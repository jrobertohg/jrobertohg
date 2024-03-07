package service

import (
	"fmt"

	"main.go/entities"
)

func ConsultarPoliza(IdPoliza int) entities.ListaPolizas {

	fmt.Println("Inicio PolizaService::ConsultarPoliza")

	var listaPolizas = entities.ListaPolizas{}

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return listaPolizas
	}

	defer db.Close()

	//Ejecutar la función de PostgreSQL
	rows, err := db.Query("SELECT idpoliza, nombre_cliente, empleado_genero, nombre, apellido, puesto, sku, nombre_articulo, descripcion_articulo, cantidad, fechamovto FROM FUN_CONSULTARPOLIZA($1::INTEGER)", IdPoliza)

	if err != nil {

		fmt.Println("Respuesta:", err)

		return listaPolizas
	}

	defer rows.Close()

	// Recorrer los resultados
	for rows.Next() {

		var poliza = entities.Poliza{}

		err := rows.Scan(&poliza.Id, &poliza.NombreCliente, &poliza.EmpleadoGenero, &poliza.Empleado.Nombre, &poliza.Empleado.Apellido, &poliza.Empleado.Puesto,
			&poliza.Sku, &poliza.Inventario.NombreArticulo, &poliza.Inventario.DescripcionArticulo, &poliza.Cantidad, &poliza.FechaMovto)

		listaPolizas = append(listaPolizas, poliza)

		if err != nil {

			fmt.Println("Error al llamar la funcion y leer los resultados", err)

			return listaPolizas

		}

	}

	fmt.Println("Termina PolizaService::ConsultarPoliza")

	return listaPolizas
}

func GuardarPoliza(poliza entities.Poliza) int {

	fmt.Println("Inicio PolizaService::GuardarPoliza")

	var resultado int = 0

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return resultado
	}

	//Preparar la consulta
	stmt, err := db.Prepare("SELECT FUN_GUARDARPOLIZA FROM FUN_GUARDARPOLIZA($1::INTEGER, $2::VARCHAR(30), $3::INTEGER, $4::INTEGER, $5::INTEGER)")

	if err != nil {

		fmt.Println("Error al preparar el statement a la base de datos", err)

		return resultado

	}

	defer stmt.Close()

	//Ejecutar la consulta y obtener los resultados
	err = stmt.QueryRow(poliza.Id, poliza.NombreCliente, poliza.EmpleadoGenero, poliza.Sku, poliza.Cantidad).Scan(&resultado)

	if err != nil {

		fmt.Println("Error al ejecutar la funcion FUN_GUARDARPOLIZA", err)

		return resultado

	}

	fmt.Println("Resultado:", resultado)

	return resultado
}

func EliminarPoliza(idPoliza int) int {

	fmt.Println("Inicio PolizaService::EliminarPoliza")

	var resultado int

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return resultado
	}

	//Preparar la consulta
	stmt, err := db.Prepare("SELECT FUN_ELIMINARPOLIZA FROM FUN_ELIMINARPOLIZA($1::INTEGER)")

	if err != nil {

		fmt.Println("Error al preparar el statement a la base de datos", err)

		return resultado

	}

	defer stmt.Close()

	//Ejecutar la consulta y obtener los resultados
	err = stmt.QueryRow(idPoliza).Scan(&resultado)

	if err != nil {

		fmt.Println("Error al ejecutar la funcion FUN_ELIMINARPOLIZA", err)

		return resultado

	}

	fmt.Println("Resultado:", resultado)

	return resultado
}
