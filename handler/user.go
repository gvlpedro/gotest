package handler

import (
	"github.com/gvlpedro/gotest/model"
	"github.com/gvlpedro/gotest/view/user"
	"github.com/labstack/echo/v4"
)

type UserHandler struct{}

func (h UserHandler) HandleUserShow(c echo.Context) error {
	xUser := model.User{
		Email:"x@x.com",
	}
	return render(c, user.Show(xUser))

}
