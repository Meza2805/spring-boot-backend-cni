package com.cni.firstexample.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
    public ResponseEntity<Profesor> obtenerPorId(@PathVariable Long id) {
        return profesorRepository.findById(id)
                .map(profesor -> ResponseEntity.ok(profesor))
                .orElse(ResponseEntity.notFound().build());
    }

    // POST: http://localhost:8081/api/profesores
    @PostMapping
    public ResponseEntity<Profesor> crearProfesor(@RequestBody Profesor profesor) {
        Profesor nuevoProfesor = profesorRepository.save(profesor);
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevoProfesor);
    }

    // PUT: http://localhost:8081/api/profesores/1
    @PutMapping("/{id}")
    public ResponseEntity<Profesor> actualizarProfesor(@PathVariable Long id, @RequestBody Profesor profesorDetalles) {
        return profesorRepository.findById(id)
                .map(profesor -> {
                    profesor.setNombre(profesorDetalles.getNombre());
                    profesor.setEspecialidad(profesorDetalles.getEspecialidad());
                    profesor.setTelefono(profesorDetalles.getTelefono());

                    Profesor profesorActualizado = profesorRepository.save(profesor);
                    return ResponseEntity.ok(profesorActualizado);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // DELETE: http://localhost:8081/api/profesores/1
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProfesor(@PathVariable Long id) {
        if (!profesorRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        profesorRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}