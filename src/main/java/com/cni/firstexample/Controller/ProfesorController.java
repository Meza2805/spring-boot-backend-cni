package com.cni.firstexample.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cni.firstexample.Model.Profesor;
import com.cni.firstexample.Repository.ProfesorRepository;

@RestController
@RequestMapping("/api/profesores")
public class ProfesorController {
     @Autowired
    private ProfesorRepository profesorRepository;

    // GET: http://localhost:8081/api/profesores
    @GetMapping
    public List<Profesor> obtenerTodos() {
        return profesorRepository.findAll();
    }

    // GET por ID: http://localhost:8081/api/profesores/1
    @GetMapping("/{id}")
    public Profesor obtenerPorId(@PathVariable Long id) {
        return profesorRepository.findById(id).orElse(null);
    }

    // POST: http://localhost:8081/api/profesores
    @PostMapping
    public Profesor crearProfesor(@RequestBody Profesor profesor) {
        return profesorRepository.save(profesor);
    }
}
