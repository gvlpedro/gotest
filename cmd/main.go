package main

import (
	"context"
	"log"
	"os"

	"github.com/gvlpedro/gotest/handler"
	store "github.com/gvlpedro/gotest/internal/storage"
	"github.com/labstack/echo/v4"
)

func main() {
	logger := log.New(os.Stdout, "[Test] ", log.LstdFlags)
	app := echo.New()
	userHandler := handler.UserHandler{}

	logger.Print("Creating guests store..")
	guestDb := store.NewGuestStore(logger)
	guestDb.AddGuest(store.Guest{Name: "admin", Email: "admin@email.com"})

	app.Use(authenticate)
	app.Static("/static", "static")
	app.GET("/user", userHandler.HandleUserShow)
	logger.Print("Serving site at http://localhost:3001/user ..")

	app.Start(":3001")
}

func authenticate(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := context.WithValue(c.Request().Context(), "email", "g@gmail.com")
		c.SetRequest(c.Request().WithContext(ctx))
		return next(c)
	}
}
