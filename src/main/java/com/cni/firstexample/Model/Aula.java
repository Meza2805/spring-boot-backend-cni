package com.cni.firstexample.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "aula")
public class Aula {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "codigo_aula", nullable = false, unique = true, length = 10)
    private String codigo;

    @Column(name = "capacidad")
    private Integer capacidad;

    @Column(name = "tiene_proyector")
    private Boolean tieneProyector = true;

    public Aula() {
    }

    public Aula(String codigo, Integer capacidad, Boolean tieneProyector) {
        this.codigo = codigo;
        this.capacidad = capacidad;
        this.tieneProyector = tieneProyector;
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Integer getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(Integer capacidad) {
        this.capacidad = capacidad;
    }

    public Boolean getTieneProyector() {
        return tieneProyector;
    }

    public void setTieneProyector(Boolean tieneProyector) {
        this.tieneProyector = tieneProyector;
    }
}
