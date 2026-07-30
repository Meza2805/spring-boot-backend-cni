package com.cni.firstexample.Controller;

import java.util.List;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cni.firstexample.Model.Estudiante;

@RestController
@RequestMapping("/api/v1/estudiantes")
public class EstudianteController {

    // GET http://localhost:8081/api/v1/estudiantes
    @GetMapping
    public List<Estudiante> obtenerTodos() {
        return List.of(
            new Estudiante(1L, "Marvin Meza", "Ingeniería en Sistemas", 22),
            new Estudiante(2L, "Meyling Pérez", "Zootecnia", 21),
            new Estudiante(3L, "Carlos López", "Informática Educativa", 18),
            new Estudiante(4L, "Adrian López", "Medicina", 23),
            new Estudiante(5L, "Gabriel López", "Antropología", 35),
            new Estudiante(6L, "Josie López", "Música", 18)
        );
    }

    // GET http://localhost:8081/api/v1/estudiantes/1
    @GetMapping("/{id}")
    public Estudiante obtenerPorId(@PathVariable Long id) {
        if (id == 15)
        {
            return new Estudiante(id, "Estudiante Encontrado", "Computación", 20);
        }
        else
        {
            return new Estudiante(id, "Estudiante No Encontrado", "N/A", 0);
        }
    }
}