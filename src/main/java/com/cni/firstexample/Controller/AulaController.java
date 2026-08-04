package com.cni.firstexample.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cni.firstexample.Model.Aula;
import com.cni.firstexample.Repository.AulaRepository;

@RestController
@RequestMapping("/api/aulas")
public class AulaController {
     @Autowired
    private AulaRepository aulaRepository;

    // GET: http://localhost:8081/api/aulas
    @GetMapping
    public List<Aula> obtenerTodas() {
        return aulaRepository.findAll();
    }

    // GET por ID: http://localhost:8081/api/aulas/1
    @GetMapping("/{id}")
    public Aula obtenerPorId(@PathVariable Long id) {
        return aulaRepository.findById(id).orElse(null);
    }

    // POST: http://localhost:8081/api/aulas
    @PostMapping
    public Aula crearAula(@RequestBody Aula aula) {
        return aulaRepository.save(aula);
    }
}
