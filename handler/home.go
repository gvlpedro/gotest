package handler

import (
	"net/http"
	"github.com/gvlpedro/gotest/model"
	"github.com/gvlpedro/gotest/view/home"
	"github.com/gvlpedro/gotest/view/layout"
	"github.com/labstack/echo/v4"
)

type HomeHandler struct{}

func (h HomeHandler) HandleHomeShow(c echo.Context) error {
	var signUpValues = model.SignUpValues{}
	var errors = make(map[string]string)
	return render(c, layout.Base(home.Home(signUpValues, errors), "Home", "/"))
}

func (h HomeHandler) SignUp(c echo.Context) error {
	var signUpValues model.SignUpValues
	if err := c.Bind(&signUpValues); err != nil {
		return c.String(http.StatusBadRequest, "Invalid signup form request")
	}
	c.Logger().Info(signUpValues)

	formErrors :=  signUpValues.Validate()
	if len(formErrors) > 0 {
		return render(c, home.SignUpFormWidget(signUpValues, signUpValues.Validate()))
	} else {
		return render(c, home.SignUpOK(signUpValues.Email))
	}
}