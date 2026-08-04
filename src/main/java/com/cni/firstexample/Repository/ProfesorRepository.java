package com.cni.firstexample.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cni.firstexample.Model.Profesor;

public interface ProfesorRepository extends JpaRepository<Profesor, Long> {
    
}
