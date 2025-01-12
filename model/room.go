package model

type Room struct {
	Id        string `json:"id" binding:"required"`
}

type Member struct {
	Name        string `json:"name" binding:"required"`
	Email            string `json:"email" binding:"required"`
}