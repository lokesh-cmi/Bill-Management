package handler

import (
	"encoding/json"
	"net/http"
	"net/url"
	"strconv"

	"github.com/gorilla/mux"
	"github.com/micro/micro/v3/service/logger"
)

var customerTableName = "customer"

type Customer struct {
	ID          uint64 `gorm:"primaryKey" json:"id,omitempty"`
	FirstName   string `json:"first_name,omitempty"`
	LastName    string `json:"last_name,omitempty"`
	Email       string `json:"email,omitempty"`
	PhoneNumber string `json:"phone_number,omitempty"`
	Address     string `json:"address,omitempty"`
}

func AddCustomer(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	var customerData Customer
	_ = json.NewDecoder(request.Body).Decode(&customerData)

	e := dbClient.Table(customerTableName).Create(&customerData)
	if e.Error != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + e.Error.Error() + `" }`))
		return
	}
	logger.Infof("Inserted customer data")
	json.NewEncoder(response).Encode(customerData)
}

func ReadCustomerById(response http.ResponseWriter, r *http.Request) {
	response.Header().Set("content-type", "application/json")
	params := mux.Vars(r)
	id := params["id"]
	var customerData Customer
	e := dbClient.Table(customerTableName).First(&customerData, id)
	if e.Error != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + e.Error.Error() + `" }`))
		return
	}
	logger.Infof("Fetched Customer With Id:" + id)
	json.NewEncoder(response).Encode(customerData)
}

func GetCustomers(response http.ResponseWriter, r *http.Request) {
	response.Header().Set("content-type", "application/json")
	var customers []Customer
	e := dbClient.Table(customerTableName).Find(&customers)
	if e.Error != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + e.Error.Error() + `" }`))
		return
	}
	logger.Infof("Fetched all Customers")
	json.NewEncoder(response).Encode(customers)
}

func UpdateCustomer(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	var customerData Customer
	var existingCustomer Customer
	_ = json.NewDecoder(request.Body).Decode(&customerData)
	dbClient.Table(customerTableName).First(&existingCustomer, customerData.ID)

	//Exclude ID field from invoiceData before updating
	customerDataWithoutID := Customer{
		FirstName:   customerData.FirstName,
		LastName:    customerData.LastName,
		Email:       customerData.Email,
		PhoneNumber: customerData.PhoneNumber,
		Address:     customerData.Address,
	}

	dbClient.Table(customerTableName).First(&existingCustomer, customerDataWithoutID)
	dbClient.Table(customerTableName).Model(&existingCustomer).Updates(customerDataWithoutID)

	logger.Infof("Updated Customer with Id:" + strconv.FormatUint(customerData.ID, 10))
	json.NewEncoder(response).Encode("Updated Customer with Id:" + strconv.FormatUint(customerData.ID, 10))
}

func DeleteCustomer(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	var customerData Customer
	queryParams, err := url.ParseQuery(request.URL.RawQuery)
	if err != nil {
		http.Error(response, "Error parsing query parameters", http.StatusBadRequest)
		return
	}
	idValues, ok := queryParams["id"]
	if !ok || len(idValues) == 0 {
		http.Error(response, "Missing or empty 'id' parameter", http.StatusBadRequest)
		return
	}
	id := idValues[0]
	result := dbClient.Table(customerTableName).Where("id = ?", id).Delete(&customerData)
	if result.RowsAffected == 0 {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`Unable to delete Please Verify`))
		return
	}
	logger.Infof("Deleted Customer with Id:" + id)
	json.NewEncoder(response).Encode(result.RowsAffected)
}
