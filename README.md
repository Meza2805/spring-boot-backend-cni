# 🚀 Curso de Desarrollo BackEnd con Java & Spring Boot

Bienvenido al repositorio oficial del Módulo Formativo **Desarrollo BackEnd con Java**, impartido en el **Centro Nacional de Innovación y Tecnología "Francisco el Chele Moreno"** (Turno Nocturno).

---

## 📌 Descripción del Proyecto Base (`firstexample`)

Este repositorio contiene el código fuente desarrollado paso a paso durante las sesiones presenciales del curso. A lo largo de las semanas, los estudiantes encontrarán la implementación progresiva de:

* 🧩 **Programación Orientada a Objetos (POO):** Abstracción, Encapsulamiento, Herencia y Polimorfismo.
* 📐 **Arquitectura Limpia & Principios SOLID:** Código desacoplado, testeable y mantenible.
* 🌐 **Spring Boot & REST APIs:** Controladores (`@RestController`), mapeo de rutas y gestión de peticiones HTTP.
* 🗄️ **Persistencia & Mapeo ORM:** Integración con **Spring Data JPA** e **Hibernate**.
* 🔄 **Conexión Multi-SGBD:** Configuración dinámica para trabajar con **SQLite** y **MySQL** mediante migraciones *Code-First* (`ddl-auto=update`).

---

## 📁 Estructura del Proyecto

```text
src/main/java/com/cni/firstexample/
├── Controller/     # Exposición de Endpoints REST (AulaController, CursoController, ProfesorController)
├── Model/          # Entidades Mapeadas con JPA (@Entity, @Table, @Id)
├── Repository/     # Interfaces de Acceso a Datos (JpaRepository)
└── FirstexampleApplication.java
