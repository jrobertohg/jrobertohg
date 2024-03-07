package handlers

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strconv"

	"main.go/entities"
	"main.go/service"
)

func ConsultarEmpleado(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio EmpleadoHandler::ConsultarEmpleado")

	var response = entities.Response{}

	var listaEmpleados = entities.ListaEmpleados{}

	queryParams := r.URL.Query()

	idEmpleado := queryParams.Get("id")

	id, _ := strconv.Atoi(idEmpleado)

	listaEmpleados = service.ConsultarEmpleado(id)

	if len(listaEmpleados) > 0 {

		response.Meta = "OK"

		response.Data = listaEmpleados

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	} else {

		response.Meta = "Failure"

		response.Data = listaEmpleados

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	}

	fmt.Println("Termina EmpleadoHandler::ConsultarEmpleado")

}

func GuardarEmpleado(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio EmpleadoHandler::GuardarEmpleado")

	var empleado = entities.Empleado{}

	var response = entities.Response{}

	var respuesta int = 0

	body, err := io.ReadAll(r.Body)

	if err != nil {

		http.Error(w, "Error al leer el cuerpo de la solicitud", http.StatusBadRequest)

		return
	}

	defer r.Body.Close()

	err = json.Unmarshal(body, &empleado)

	if err != nil {

		fmt.Println("error", err)

	}

	respuesta = service.GuardarEmpleado(empleado)

	if respuesta > 0 {

		response.Meta = "OK"

		response.Data = respuesta

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	} else {

		response.Meta = "Failure"

		response.Data = respuesta

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	}

	fmt.Println("Termina EmpleadoHandler::GuardarEmpleado")

}

func EliminarEmpleado(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio EmpleadoHandler::EliminarEmpleado")

	var response = entities.Response{}

	var respuesta int = 0

	queryParams := r.URL.Query()

	sku := queryParams.Get("sku")

	iSku, _ := strconv.Atoi(sku)

	respuesta = service.EliminarEmpleado(iSku)

	if respuesta > 0 {

		response.Meta = "OK"

		response.Data = respuesta

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	} else {

		response.Meta = "Failure"

		response.Data = respuesta

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	}

	fmt.Println("Termina EmpleadoHandler::EliminarEmpleado")
}
