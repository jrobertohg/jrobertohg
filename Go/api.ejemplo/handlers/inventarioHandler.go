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

func ConsultarInventario(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio InventarioHandler::ConsultarInventario")

	var response = entities.Response{}

	var listaInventarios = entities.ListaInventarios{}

	queryParams := r.URL.Query()

	sku := queryParams.Get("sku")

	iSku, _ := strconv.Atoi(sku)

	listaInventarios = service.ConsultarInventario(iSku)

	if len(listaInventarios) > 0 {

		response.Meta = "OK"

		response.Data = listaInventarios

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	} else {

		response.Meta = "Failure"

		response.Data = listaInventarios

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	}

	fmt.Println("Termina InventarioHandler::ConsultarInventario")

}

func GuardarInventario(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio InventarioHandler::GuardarInventario")

	var inventario = entities.Inventario{}

	var response = entities.Response{}

	var respuesta int = 0

	body, err := io.ReadAll(r.Body)

	if err != nil {

		http.Error(w, "Error al leer el cuerpo de la solicitud", http.StatusBadRequest)

		return
	}

	defer r.Body.Close()

	err = json.Unmarshal(body, &inventario)

	if err != nil {

		fmt.Println("error", err)

	}

	respuesta = service.GuardarInventario(inventario)

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

	fmt.Println("Termina InventarioHandler::GuardarInventario")

}

func EliminarInventario(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio InventarioHandler::EliminarInventario")

	var response = entities.Response{}

	var respuesta int = 0

	queryParams := r.URL.Query()

	sku := queryParams.Get("sku")

	iSku, _ := strconv.Atoi(sku)

	respuesta = service.EliminarInventario(iSku)

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

	fmt.Println("Termina InventarioHandler::EliminarInventario")

}
