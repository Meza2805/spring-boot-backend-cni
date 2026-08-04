package com.cni.firstexample.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cni.firstexample.Model.Aula;

@Repository
public interface AulaRepository extends JpaRepository<Aula, Long> {
    
}
