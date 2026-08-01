package com.cni.firstexample.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cni.firstexample.Model.ProfesorModel;

@Repository
public interface ProfesorRepository extends JpaRepository<ProfesorModel, Long> {
}
