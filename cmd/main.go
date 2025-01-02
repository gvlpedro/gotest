package main

import (
	"context"

	"github.com/gvlpedro/gotest/handler"
	"github.com/labstack/echo/v4"
)

func main() {
	app := echo.New()
	userHandler := handler.UserHandler{}
	app.Use(authenticate)
	app.GET("/user", userHandler.HandleUserShow)
	
	app.Start(":3000")
}

func authenticate(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := context.WithValue(c.Request().Context(), "email", "g@gmail.com")
		c.SetRequest(c.Request().WithContext(ctx))
		return next(c)
	}
}
