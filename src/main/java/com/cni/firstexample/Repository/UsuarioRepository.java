package com.cni.firstexample.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cni.firstexample.Model.Usuario;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    // Método indispensable para la autenticación en Spring Security
    Optional<Usuario> findByUsername(String username);

    // Buscar por correo electrónico
    Optional<Usuario> findByEmail(String email);

    // Validaciones rápidas para registro de nuevos usuarios
    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    // Consulta con JOIN en JPQL para obtener usuarios que posean un determinado rol
    @Query("SELECT u FROM Usuario u JOIN u.roles r WHERE r.nombre = :nombreRol")
    List<Usuario> buscarPorNombreRol(@Param("nombreRol") String nombreRol);
}