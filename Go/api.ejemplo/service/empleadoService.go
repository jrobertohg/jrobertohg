package service

import (
	"fmt"

	"main.go/entities"
)

func ConsultarEmpleado(idEmpleado int) entities.ListaEmpleados {

	fmt.Println("Inicio EmpleadoService::ConsultarEmpleado")

	var listaEmpleados = entities.ListaEmpleados{}

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return listaEmpleados
	}

	defer db.Close()

	//Ejecutar la función de PostgreSQL
	rows, err := db.Query("SELECT idEmpleado, nombre, apellido, puesto, fechamovto FROM FUN_CONSULTAREMPLEADO($1::INTEGER)", idEmpleado)

	if err != nil {

		fmt.Println("Respuesta:", err)

		return listaEmpleados
	}

	defer rows.Close()

	// Recorrer los resultados
	for rows.Next() {

		var empleado = entities.Empleado{}

		err := rows.Scan(&empleado.Id, &empleado.Nombre, &empleado.Apellido, &empleado.Puesto, &empleado.FechaMovto)

		listaEmpleados = append(listaEmpleados, empleado)

		if err != nil {

			fmt.Println("Error al llamar la funcion y leer los resultados", err)

			return listaEmpleados
		}

	}

	fmt.Println("Termina EmpleadoService::ConsultarEmpleado")

	return listaEmpleados
}

func GuardarEmpleado(empleado entities.Empleado) int {

	fmt.Println("Inicio EmpleadoService::GuardarEmpleado")

	var resultado int = 0

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return resultado
	}

	defer db.Close()

	//Preparar la consulta
	stmt, err := db.Prepare("SELECT FUN_GUARDAREMPLEADO FROM FUN_GUARDAREMPLEADO($1::INTEGER, $2::varchar(30), $3::varchar(50), $4::varchar(30))")

	if err != nil {

		fmt.Println("Error al preparar el statement a la base de datos", err)

		return resultado

	}

	defer stmt.Close()

	//Ejecutar la consulta y obtener los resultados
	err = stmt.QueryRow(empleado.Id, empleado.Nombre, empleado.Apellido, empleado.Puesto).Scan(&resultado)

	if err != nil {

		fmt.Println("Error al ejecutar la funcion FUN_GUARDAREMPLEADO", err)

		return resultado

	}

	fmt.Println("Resultado:", resultado)

	return resultado
}

func EliminarEmpleado(idEmpleado int) int {

	fmt.Println("Inicio EmpleadoService::EliminarEmpleado")

	var resultado int = 0

	//Obtener la conexion de la bd
	db, err := ObtenerConexion()

	if err != nil {

		fmt.Println("Respuesta:", err)

		return resultado
	}
	//Preparar la consulta
	stmt, err := db.Prepare("SELECT FUN_ELIMINAREMPLEADO FROM FUN_ELIMINAREMPLEADO($1::INTEGER)")

	if err != nil {

		fmt.Println("Error al preparar el statement a la base de datos", err)

		return resultado

	}

	defer stmt.Close()

	//Ejecutar la consulta y obtener los resultados
	err = stmt.QueryRow(idEmpleado).Scan(&resultado)

	if err != nil {

		fmt.Println("Error al ejecutar la funcion FUN_ELIMINAREMPLEADO", err)

		return resultado

	}

	fmt.Println("Resultado:", resultado)

	return resultado
}
