package main

import (
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
	"main.go/handlers"
)

func main() {

	fmt.Println("Inicio")

	r := mux.NewRouter()

	r.Use(CORS)

	r.HandleFunc("/ConsultarInventario", handlers.ConsultarInventario).Methods(http.MethodGet, http.MethodOptions)

	r.HandleFunc("/GuardarInventario", handlers.GuardarInventario).Methods(http.MethodPost, http.MethodOptions)

	r.HandleFunc("/EliminarInventario", handlers.EliminarInventario).Methods(http.MethodPost, http.MethodOptions)

	r.HandleFunc("/ConsultarEmpleado", handlers.ConsultarEmpleado).Methods(http.MethodGet, http.MethodOptions)

	r.HandleFunc("/GuardarEmpleado", handlers.GuardarEmpleado).Methods(http.MethodPost, http.MethodOptions)

	r.HandleFunc("/EliminarEmpleado", handlers.EliminarEmpleado).Methods(http.MethodPost, http.MethodOptions)

	r.HandleFunc("/ConsultarPoliza", handlers.ConsultarPoliza).Methods(http.MethodGet, http.MethodOptions)

	r.HandleFunc("/GuardarPoliza", handlers.GuardarPoliza).Methods(http.MethodPost, http.MethodOptions)

	r.HandleFunc("/EliminarPoliza", handlers.EliminarPoliza).Methods(http.MethodPost, http.MethodOptions)

	fmt.Println(http.ListenAndServe(":3000", r))

}

func CORS(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

		w.Header().Set("Content-Type", "application/json")

		w.Header().Set("Access-Control-Allow-Origin", "*")

		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")

		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-Requested-With, Authorization")

		w.Header().Set("Access-Control-Allow-Credentials", "true")

		next.ServeHTTP(w, r)

		return
	})
}
