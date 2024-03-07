package service

import (
	"database/sql"
	"fmt"
	"os"

	"github.com/lib/pq"
)

var urlPostgress = os.Getenv("urlPostgress")

func ObtenerConexion() (*sql.DB, error) {

	//Creamos la conexión a la base de datos
	db, err := sql.Open("postgres", "user=postgres password=admin dbname=Polizas sslmode=disable")

	if err != nil {

		fmt.Println("Error al conectarse a la base de datos")

		if err, ok := err.(*pq.Error); ok {

			fmt.Println("Respuesta DB:", err.Message)

		}
	}

	return db, nil
}
