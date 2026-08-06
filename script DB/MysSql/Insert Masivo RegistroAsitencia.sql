USE RegistroAsistencia;

-- 1. Centros
INSERT INTO `Centros` (`nombre_centro`) VALUES
('Centro Central de Innovación'),
('Sede Regional Norte');

-- 2. Facultades
INSERT INTO `Facultades` (`id_centro`, `nombre_facultad`) VALUES
(1, 'Facultad de Ingeniería y Tecnología'),
(1, 'Facultad de Educación y Humanidades'),
(2, 'Facultad Ciencias de la Computación');

-- 3. Carreras
INSERT INTO `Carreras` (`id_facultad`, `nombre_carrera`) VALUES
(1, 'Ingeniería en Sistemas de Información'),
(1, 'Ingeniería Industrial'),
(2, 'Informática Educativa'),
(3, 'Técnico Superior en Desarrollo de Software');

-- 4. Turnos
INSERT INTO `Turnos` (`nombre_turno`) VALUES
('Matutino'),
('Vespertino'),
('Nocturno'),
('Sabatino');

-- 5. Anios_Lectivos
INSERT INTO `Anios_Lectivos` (`etiqueta`, `activo`) VALUES
('2025', false),
('2026', true);

-- 6. Asignaturas
INSERT INTO `Asignaturas` (`nombre_asignatura`) VALUES
('Base de Datos I'),
('Programación Orientada a Objetos'),
('Arquitectura de Redes'),
('Matemática Discreta'),
('Metodología de la Investigación');

-- 7. Estudiantes
INSERT INTO `Estudiantes` (`p_nombre`, `s_nombre`, `p_apellido`, `s_apellido`, `sexo`, `telefono`, `direccion`) VALUES
('Carlos', 'Alberto', 'García', 'Mendoza', 'M', '88881111', 'Colonia Central, Calle 3'),
('María', 'José', 'López', 'Ríos', 'F', '88882222', 'Barrio San Juan, Casa #45'),
('Javier', NULL, 'Rodríguez', 'Pérez', 'M', '88883333', 'Reparto Universitario'),
('Ana', 'Sofia', 'Martínez', 'Gómez', 'F', '88884444', 'Residencial Los Arcos'),
('Luis', 'Eduardo', 'Torres', 'Castro', 'M', '88885555', 'Barrio El Rosario');

-- 8. Identidades_Academicas
INSERT INTO `Identidades_Academicas` (`id_estudiante`, `id_centro`, `carnet_codigo`) VALUES
(1, 1, '2026-0001-C'),
(2, 1, '2026-0002-C'),
(3, 1, '2026-0003-C'),
(4, 2, '2026-0004-RN'),
(5, 2, '2026-0005-RN');

-- 9. Grupos
INSERT INTO `Grupos` (`id_carrera`, `nombre_grupo`, `id_turno`, `id_anio`) VALUES
(1, 'G1-SIS-2026', 1, 2), -- Ingeniería en Sistemas / Matutino / 2026
(1, 'G2-SIS-2026', 3, 2), -- Ingeniería en Sistemas / Nocturno / 2026
(3, 'G1-INF-2026', 1, 2); -- Informática Educativa / Matutino / 2026

-- 10. Horarios
INSERT INTO `Horarios` (`id_grupo`, `id_asignatura`, `dia_semana`, `hora_inicio`, `hora_fin`, `aula`) VALUES
(1, 1, 'Lunes', '08:00:00', '10:00:00', 'Lab-01'),
(1, 2, 'Miércoles', '08:00:00', '10:00:00', 'Lab-02'),
(2, 1, 'Martes', '18:00:00', '20:00:00', 'Aula-104'),
(3, 5, 'Jueves', '10:15:00', '12:00:00', 'Aula-201');

-- 11. Inscripciones
INSERT INTO `Inscripciones` (`id_estudiante`, `id_grupo`, `fecha_inscripcion`) VALUES
(1, 1, '2026-01-15'),
(2, 1, '2026-01-16'),
(3, 2, '2026-01-18'),
(4, 3, '2026-01-20'),
(5, 3, '2026-01-21');

-- 12. Asistencia
INSERT INTO `Asistencia` (`id_estudiante`, `id_horario`, `fecha`, `estado`, `observaciones`) VALUES
(1, 1, '2026-02-02', 'Presente', NULL),
(2, 1, '2026-02-02', 'Ausente', 'Justificante médico en trámite'),
(1, 2, '2026-02-04', 'Presente', NULL),
(2, 2, '2026-02-04', 'Llegada Tardia', 'Entró 15 min tarde'),
(3, 3, '2026-02-03', 'Presente', NULL);