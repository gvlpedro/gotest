package handler

import (
	"github.com/gvlpedro/gotest/view/chat"
	"github.com/gvlpedro/gotest/view/layout"
	"github.com/labstack/echo/v4"
)

type ChatHandler struct{}

func (h ChatHandler) HandleChatShow(c echo.Context) error {
	return render(c, layout.Base(chat.ChatWindow(), "Chat", "/chat"))
}

