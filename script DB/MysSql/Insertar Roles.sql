-- 1. Asegurarnos de estar utilizando la base de datos correcta
USE cni_db;

-- 2. Garantizar que la columna 'nombre' no permita valores duplicados
-- (Hibernate suele crearlo por la anotación @Column(unique = true), pero esto nos asegura la restricción)
ALTER TABLE roles ADD CONSTRAINT uq_roles_nombre UNIQUE (nombre);

-- 3. Inserción segura: IGNORE omite la fila si el valor de 'nombre' ya existe
INSERT IGNORE INTO roles (nombre) VALUES 
('ROLE_ADMIN'),
('ROLE_DOCENTE'),
('ROLE_ESTUDIANTE');

-- 4. Consulta de verificación para confirmar los registros actuales
SELECT * FROM roles;
