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

import com.cni.firstexample.Model.Aula;
import com.cni.firstexample.Repository.AulaRepository;

@RestController
@RequestMapping("/api/aulas")
public class AulaController {

    @Autowired
    private AulaRepository aulaRepository;

    // GET: Listar todas
    @GetMapping
    public List<Aula> obtenerTodas() {
        return aulaRepository.findAll();
    }

    // GET: Obtener por ID
    @GetMapping("/{id}")
    public ResponseEntity<Aula> obtenerPorId(@PathVariable Long id) {
        return aulaRepository.findById(id)
                .map(aula -> ResponseEntity.ok(aula))
                .orElse(ResponseEntity.notFound().build());
    }

    // POST: Crear
    @PostMapping
    public ResponseEntity<Aula> crearAula(@RequestBody Aula aula) {
        Aula nuevaAula = aulaRepository.save(aula);
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevaAula);
    }

    // PUT: Actualizar
    @PutMapping("/{id}")
    public ResponseEntity<Aula> actualizarAula(@PathVariable Long id, @RequestBody Aula aulaDetalles) {
        return aulaRepository.findById(id)
                .map(aula -> {
                    aula.setCodigo(aulaDetalles.getCodigo());
                    aula.setCapacidad(aulaDetalles.getCapacidad());
                    aula.setTieneProyector(aulaDetalles.getTieneProyector());
                    
                    Aula aulaActualizada = aulaRepository.save(aula);
                    return ResponseEntity.ok(aulaActualizada);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // DELETE: Eliminar
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarAula(@PathVariable Long id) {
        if (!aulaRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        aulaRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}