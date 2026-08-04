package com.cni.firstexample.DTO;

import java.util.Set;

public class RegistroUsuarioDTO {

    private String username;
    private String email;
    private String password; // Texto plano proveniente del cliente
    private Set<String> roles; // Nombres de roles, ej: ["ROLE_DOCENTE"]

    public RegistroUsuarioDTO() {
    }

    // Getters y Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Set<String> getRoles() {
        return roles;
    }

    public void setRoles(Set<String> roles) {
        this.roles = roles;
    }
}