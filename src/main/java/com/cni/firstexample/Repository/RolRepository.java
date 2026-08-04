package com.cni.firstexample.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cni.firstexample.Model.Rol;

@Repository
public interface RolRepository extends JpaRepository<Rol, Long> {

    // Buscar rol por su nombre (Ej: "ROLE_ADMIN")
    Optional<Rol> findByNombre(String nombre);

    // Verificar si un rol ya existe
    boolean existsByNombre(String nombre);
}