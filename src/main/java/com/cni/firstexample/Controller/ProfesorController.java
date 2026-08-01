package com.cni.firstexample.Controller;

import com.cni.firstexample.DTO.ProfesorDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import com.cni.firstexample.Model.ProfesorModel;
import com.cni.firstexample.Service.ProfesorService;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/profesor")
public class ProfesorController {

    private final ProfesorService profesorService;

    @GetMapping
    public List<ProfesorModel> getAllProfesor(){
        return profesorService.getAllProfesor();
    }

    @PostMapping
    public ProfesorModel createProfesor(@RequestBody ProfesorModel profesor){
        return profesorService.createProfesor(profesor);
    }

    @PutMapping("/{id}")
    public ProfesorModel updateProfesor(@PathVariable Long id, @RequestBody ProfesorDTO profesor){
        return profesorService.updateProfesor(id, profesor);
    }
}
