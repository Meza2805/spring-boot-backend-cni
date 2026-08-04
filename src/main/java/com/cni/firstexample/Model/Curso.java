package com.cni.firstexample.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "curso")
public class Curso {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
       private Long id;

    @Column(name = "nombre_curso", nullable = false, length = 120)
    private String nombre;

    @Column(name = "codigo_identificador", unique = true, nullable = false, length = 20)
    private String codigo;

    @Column(name = "duracion_horas")
    private Integer duracionHoras;

    @Column(name = "precio")
    private Double precio;

    public Curso() {
    }

    public Curso(String nombre, String codigo, Integer duracionHoras, Double precio) {
        this.nombre = nombre;
        this.codigo = codigo;
        this.duracionHoras = duracionHoras;
        this.precio = precio;
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Integer getDuracionHoras() {
        return duracionHoras;
    }

    public void setDuracionHoras(Integer duracionHoras) {
        this.duracionHoras = duracionHoras;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }
}