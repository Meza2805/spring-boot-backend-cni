Create database RegistroAsistencia;
use RegistroAsistencia;

CREATE TABLE `Centros` (
  `id_centro` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre_centro` varchar(255) NOT NULL
);

CREATE TABLE `Facultades` (
  `id_facultad` integer PRIMARY KEY AUTO_INCREMENT,
  `id_centro` integer,
  `nombre_facultad` varchar(255) NOT NULL
);

CREATE TABLE `Carreras` (
  `id_carrera` integer PRIMARY KEY AUTO_INCREMENT,
  `id_facultad` integer,
  `nombre_carrera` varchar(255) NOT NULL
);

CREATE TABLE `Turnos` (
  `id_turno` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre_turno` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `Anios_Lectivos` (
  `id_anio` integer PRIMARY KEY AUTO_INCREMENT,
  `etiqueta` varchar(255) UNIQUE NOT NULL,
  `activo` boolean DEFAULT true
);

CREATE TABLE `Asignaturas` (
  `id_asignatura` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre_asignatura` varchar(255) NOT NULL
);

CREATE TABLE `Estudiantes` (
  `id_estudiante` integer PRIMARY KEY AUTO_INCREMENT,
  `p_nombre` varchar(255) NOT NULL,
  `s_nombre` varchar(255),
  `p_apellido` varchar(255) NOT NULL,
  `s_apellido` varchar(255),
  `sexo` char(1),
  `telefono` varchar(255),
  `direccion` text
);

CREATE TABLE `Identidades_Academicas` (
  `id_identidad` integer PRIMARY KEY AUTO_INCREMENT,
  `id_estudiante` integer,
  `id_centro` integer,
  `carnet_codigo` varchar(255) NOT NULL
);

CREATE TABLE `Grupos` (
  `id_group` integer PRIMARY KEY AUTO_INCREMENT,
  `id_carrera` integer,
  `nombre_grupo` varchar(255),
  `id_turno` integer,
  `id_anio` integer
);

CREATE TABLE `Horarios` (
  `id_horario` integer PRIMARY KEY AUTO_INCREMENT,
  `id_grupo` integer,
  `id_asignatura` integer,
  `dia_semana` varchar(255),
  `hora_inicio` time,
  `hora_fin` time,
  `aula` varchar(255)
);

CREATE TABLE `Inscripciones` (
  `id_inscripcion` integer PRIMARY KEY AUTO_INCREMENT,
  `id_estudiante` integer,
  `id_grupo` integer,
  `fecha_inscripcion` date
);

CREATE TABLE `Asistencia` (
  `id_asistencia` integer PRIMARY KEY AUTO_INCREMENT,
  `id_estudiante` integer,
  `id_horario` integer,
  `fecha` date,
  `estado` varchar(255),
  `observaciones` text
);

ALTER TABLE `Facultades` ADD FOREIGN KEY (`id_centro`) REFERENCES `Centros` (`id_centro`);

ALTER TABLE `Carreras` ADD FOREIGN KEY (`id_facultad`) REFERENCES `Facultades` (`id_facultad`);

ALTER TABLE `Identidades_Academicas` ADD FOREIGN KEY (`id_estudiante`) REFERENCES `Estudiantes` (`id_estudiante`);

ALTER TABLE `Identidades_Academicas` ADD FOREIGN KEY (`id_centro`) REFERENCES `Centros` (`id_centro`);

ALTER TABLE `Grupos` ADD FOREIGN KEY (`id_carrera`) REFERENCES `Carreras` (`id_carrera`);

ALTER TABLE `Grupos` ADD FOREIGN KEY (`id_turno`) REFERENCES `Turnos` (`id_turno`);

ALTER TABLE `Grupos` ADD FOREIGN KEY (`id_anio`) REFERENCES `Anios_Lectivos` (`id_anio`);

ALTER TABLE `Horarios` ADD FOREIGN KEY (`id_grupo`) REFERENCES `Grupos` (`id_group`);

ALTER TABLE `Horarios` ADD FOREIGN KEY (`id_asignatura`) REFERENCES `Asignaturas` (`id_asignatura`);

ALTER TABLE `Inscripciones` ADD FOREIGN KEY (`id_estudiante`) REFERENCES `Estudiantes` (`id_estudiante`);

ALTER TABLE `Inscripciones` ADD FOREIGN KEY (`id_grupo`) REFERENCES `Grupos` (`id_group`);

ALTER TABLE `Asistencia` ADD FOREIGN KEY (`id_estudiante`) REFERENCES `Estudiantes` (`id_estudiante`);

ALTER TABLE `Asistencia` ADD FOREIGN KEY (`id_horario`) REFERENCES `Horarios` (`id_horario`);
