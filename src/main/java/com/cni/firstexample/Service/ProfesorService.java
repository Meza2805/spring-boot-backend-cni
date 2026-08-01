package com.cni.firstexample.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;

import org.springframework.stereotype.Service;

import com.cni.firstexample.Repository.ProfesorRepository;
import com.cni.firstexample.Model.ProfesorModel;
import com.cni.firstexample.DTO.ProfesorDTO;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProfesorService {
    private final ProfesorRepository profesorRepository;
    private final ModelMapper modelMapper;

    public List<ProfesorModel> getAllProfesor(){
        return profesorRepository.findAll();
    }

    @Transactional
    public ProfesorModel createProfesor(ProfesorModel profesor){
        return profesorRepository.save(profesor);
    }

    @Transactional
    public ProfesorModel updateProfesor(Long id, ProfesorDTO profesorDTO ){
        Optional<ProfesorModel> existingProfesorOpt = profesorRepository.findById(id);

        if (existingProfesorOpt.isEmpty()){
            throw new RuntimeException("Profesor no encontrado con id: " + id);
        }

       ProfesorModel existingProfesor = existingProfesorOpt.get();

       modelMapper.map(profesorDTO, existingProfesor);

       return profesorRepository.save(existingProfesor);
    }



}
