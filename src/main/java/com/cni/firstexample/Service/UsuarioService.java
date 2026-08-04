package com.cni.firstexample.Service;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cni.firstexample.DTO.RegistroUsuarioDTO;
import com.cni.firstexample.Model.Rol;
import com.cni.firstexample.Model.Usuario;
import com.cni.firstexample.Repository.RolRepository;
import com.cni.firstexample.Repository.UsuarioRepository;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private RolRepository rolRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public Usuario registrarUsuario(RegistroUsuarioDTO dto) {
        // 1. Validaciones
        if (usuarioRepository.existsByUsername(dto.getUsername())) {
            throw new RuntimeException("Error: El nombre de usuario ya existe.");
        }

        if (usuarioRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("Error: El correo electrónico ya está registrado.");
        }

        // 2. Crear instancia de Usuario
        Usuario usuario = new Usuario();
        usuario.setUsername(dto.getUsername());
        usuario.setEmail(dto.getEmail());

        // 3. ENCRIPTAR LA CONTRASEÑA CON BCRYPT
        String passwordEncriptada = passwordEncoder.encode(dto.getPassword());
        usuario.setPassword(passwordEncriptada);

        // 4. Asignar Roles
        Set<Rol> roles = new HashSet<>();
        if (dto.getRoles() == null || dto.getRoles().isEmpty()) {
            // Rol por defecto si no especifica ninguno
            Rol rolDefault = rolRepository.findByNombre("ROLE_ESTUDIANTE")
                    .orElseThrow(() -> new RuntimeException("Error: Rol no encontrado."));
            roles.add(rolDefault);
        } else {
            dto.getRoles().forEach(nombreRol -> {
                Rol rol = rolRepository.findByNombre(nombreRol)
                        .orElseThrow(() -> new RuntimeException("Error: El rol " + nombreRol + " no existe."));
                roles.add(rol);
            });
        }
        usuario.setRoles(roles);

        // 5. Guardar en Base de Datos
        return usuarioRepository.save(usuario);
    }
}