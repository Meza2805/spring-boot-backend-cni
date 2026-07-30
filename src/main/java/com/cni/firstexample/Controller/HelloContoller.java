package com.cni.firstexample.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/hola")
public class HelloContoller {

    //@GetMapping
  @GetMapping("/Saludo")
    public String saludar() {
        return "¡Hola estudiantes! Nuestro backend con Spring Boot en VS Code está funcionando.";
    }
 @GetMapping("/Bienvenida")
    public String bienvenida() {
        return "Bienvenido";
    }

}


// @RequestMapping("/api/v1/Test")
// public class Test{
//     @GetMapping
//     public string 
// }