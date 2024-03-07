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

func ConsultarPoliza(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio PolizaHandler::ConsultarPoliza")

	var response = entities.Response{}

	var listaPolizas = entities.ListaPolizas{}

	queryParams := r.URL.Query()

	idPoliza := queryParams.Get("id")

	id, _ := strconv.Atoi(idPoliza)

	listaPolizas = service.ConsultarPoliza(id)

	if len(listaPolizas) > 0 {

		response.Meta = "OK"

		response.Data = listaPolizas

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))
	} else {

		response.Meta = "Failure"

		response.Data = listaPolizas

		response, _ := json.Marshal(response)

		fmt.Fprintf(w, string(response))

	}

	fmt.Println("Termina PolizaHandler::ConsultarPoliza")

}

func GuardarPoliza(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio PolizaHandler::GuardarPoliza")

	var poliza = entities.Poliza{}

	var response = entities.Response{}

	var respuesta int = 0

	body, err := io.ReadAll(r.Body)

	if err != nil {

		http.Error(w, "Error al leer el cuerpo de la solicitud", http.StatusBadRequest)

		return
	}

	defer r.Body.Close()

	err = json.Unmarshal(body, &poliza)

	if err != nil {

		fmt.Println("error", err)

	}

	respuesta = service.GuardarPoliza(poliza)

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

	fmt.Println("Termina PolizaHandler::GuardarPoliza")

}

func EliminarPoliza(w http.ResponseWriter, r *http.Request) {

	if r.Method == "OPTIONS" {
		return
	}

	fmt.Println("Inicio PolizaHandler::EliminarPoliza")

	var response = entities.Response{}

	var respuesta int = 0

	queryParams := r.URL.Query()

	sku := queryParams.Get("sku")

	iSku, _ := strconv.Atoi(sku)

	respuesta = service.EliminarPoliza(iSku)

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

	fmt.Println("Termina PolizaHandler::EliminarPoliza")

}
