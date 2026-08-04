package com.cni.firstexample.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cni.firstexample.Model.Curso;
import com.cni.firstexample.Repository.CursoRepository;

@RestController
@RequestMapping("/api/cursos")
public class CursoController {
     @Autowired
    private CursoRepository cursoRepository;

    // GET: http://localhost:8081/api/cursos
    @GetMapping
    public List<Curso> obtenerTodos() {
        return cursoRepository.findAll();
    }

    // GET por ID: http://localhost:8081/api/cursos/1
    @GetMapping("/{id}")
    public Curso obtenerPorId(@PathVariable Long id) {
        return cursoRepository.findById(id).orElse(null);
    }

    // POST: http://localhost:8081/api/cursos
    @PostMapping
    public Curso crearCurso(@RequestBody Curso curso) {
        return cursoRepository.save(curso);
    }
}
