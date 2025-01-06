package model

import (
	"fmt"
	//"regexp"
)

type SignUpValues struct {
	FirstName        string `json:"first-name" binding:"required"`
	LastName         string `json:"last-name" binding:"required"`
	Email            string `json:"email" binding:"required"`
	Password         string `json:"password" binding:"required"`
	RepeatedPassword string `json:"repeated-password" binding:"required"`
}

// TODO: Errors based on a PoC, remove values from errors
func (values *SignUpValues) Validate() map[string]string {
	errors := map[string]string{}
	if len(values.FirstName) < 2 || len(values.FirstName) > 30 {
		errors["FirstName"] = fmt.Sprintf("[%s] The length of first name must be between 2 and 30 characters long", values.FirstName)
	}
	if len(values.LastName) < 2 || len(values.LastName) > 30 {
		errors["LastName"] = fmt.Sprintf("[%s] The length of first name must be between 2 and 30 characters long", values.LastName)
	}
    //emailRegex := regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
	if len(values.Email) < 3  { // || emailRegex.MatchString(values.Email)
		errors["Email"] = fmt.Sprintf("[%s] Email has wrong format", values.Email)
	}
	if len(values.Password) < 4 {
		errors["Password"] = fmt.Sprintf("[%s] The length of password must be greater than 4 characters", values.Password)
	}
	if values.Password != values.RepeatedPassword {
		errors["RepeatedPassword"] = fmt.Sprintf("[%s != %s] Passwords should be the same", values.Password, values.RepeatedPassword)
	}
	return errors
}
