package main

import "github.com/gin-gonic/gin"

func helloHandler(c *gin.Context) {
	c.String(200, "Hello Go App！")
}

func main() {
	r := gin.Default()

	r.GET("/hello", helloHandler)

	if err := r.Run(":8080"); err != nil {
		panic(err)
	}
}
