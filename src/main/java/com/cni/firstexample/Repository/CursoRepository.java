package com.cni.firstexample.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cni.firstexample.Model.Curso;

@Repository
public interface  CursoRepository extends JpaRepository<Curso, Long> {
    
}
