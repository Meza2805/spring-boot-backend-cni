USE [RegistroAsistencia];
GO

-- 1. Centros
INSERT INTO [Centros] ([nombre_centro]) VALUES
(N'Centro Central de Innovación'),
(N'Sede Regional Norte');
GO

-- 2. Facultades
INSERT INTO [Facultades] ([id_centro], [nombre_facultad]) VALUES
(1, N'Facultad de Ingeniería y Tecnología'),
(1, N'Facultad de Educación y Humanidades'),
(2, N'Facultad Ciencias de la Computación');
GO

-- 3. Carreras
INSERT INTO [Carreras] ([id_facultad], [nombre_carrera]) VALUES
(1, N'Ingeniería en Sistemas de Información'),
(1, N'Ingeniería Industrial'),
(2, N'Informática Educativa'),
(3, N'Técnico Superior en Desarrollo de Software');
GO

-- 4. Turnos
INSERT INTO [Turnos] ([nombre_turno]) VALUES
(N'Matutino'),
(N'Vespertino'),
(N'Nocturno'),
(N'Sabatino');
GO

-- 5. Anios_Lectivos (0 = Inactivo, 1 = Activo)
INSERT INTO [Anios_Lectivos] ([etiqueta], [activo]) VALUES
(N'2025', 0),
(N'2026', 1);
GO

-- 6. Asignaturas
INSERT INTO [Asignaturas] ([nombre_asignatura]) VALUES
(N'Base de Datos I'),
(N'Programación Orientada a Objetos'),
(N'Arquitectura de Redes'),
(N'Matemática Discreta'),
(N'Metodología de la Investigación');
GO

-- 7. Estudiantes
INSERT INTO [Estudiantes] ([p_nombre], [s_nombre], [p_apellido], [s_apellido], [sexo], [telefono], [direccion]) VALUES
(N'Carlos', N'Alberto', N'García', N'Mendoza', 'M', N'88881111', N'Colonia Central, Calle 3'),
(N'María', N'José', N'meLópez', N'Ríos', 'F', N'88882222', N'Barrio San Juan, Casa #45'),
(N'Javier', NULL, N'Rodríguez', N'Pérez', 'M', N'88883333', N'Reparto Universitario'),
(N'Ana', N'Sofia', N'Martínez', N'Gómez', 'F', N'88884444', N'Residencial Los Arcos'),
(N'Luis', N'Eduardo', N'Torres', N'Castro', 'M', N'88885555', N'Barrio El Rosario');
GO

-- 8. Identidades_Academicas
INSERT INTO [Identidades_Academicas] ([id_estudiante], [id_centro], [carnet_codigo]) VALUES
(1, 1, N'2026-0001-C'),
(2, 1, N'2026-0002-C'),
(3, 1, N'2026-0003-C'),
(4, 2, N'2026-0004-RN'),
(5, 2, N'2026-0005-RN');
GO

-- 9. Grupos
INSERT INTO [Grupos] ([id_carrera], [nombre_grupo], [id_turno], [id_anio]) VALUES
(1, N'G1-SIS-2026', 1, 2), -- Ingeniería en Sistemas / Matutino / 2026
(1, N'G2-SIS-2026', 3, 2), -- Ingeniería en Sistemas / Nocturno / 2026
(3, N'G1-INF-2026', 1, 2); -- Informática Educativa / Matutino / 2026
GO

-- 10. Horarios
INSERT INTO [Horarios] ([id_grupo], [id_asignatura], [dia_semana], [hora_inicio], [hora_fin], [aula]) VALUES
(1, 1, N'Lunes', '08:00:00', '10:00:00', N'Lab-01'),
(1, 2, N'Miércoles', '08:00:00', '10:00:00', N'Lab-02'),
(2, 1, N'Martes', '18:00:00', '20:00:00', N'Aula-104'),
(3, 5, N'Jueves', '10:15:00', '12:00:00', N'Aula-201');
GO

-- 11. Inscripciones
INSERT INTO [Inscripciones] ([id_estudiante], [id_grupo], [fecha_inscripcion]) VALUES
(1, 1, '2026-01-15'),
(2, 1, '2026-01-16'),
(3, 2, '2026-01-18'),
(4, 3, '2026-01-20'),
(5, 3, '2026-01-21');
GO

-- 12. Asistencia
INSERT INTO [Asistencia] ([id_estudiante], [id_horario], [fecha], [estado], [observaciones]) VALUES
(1, 1, '2026-02-02', N'Presente', NULL),
(2, 1, '2026-02-02', N'Ausente', N'Justificante médico en trámite'),
(1, 2, '2026-02-04', N'Presente', NULL),
(2, 2, '2026-02-04', N'Llegada Tardia', N'Entró 15 min tarde'),
(3, 3, '2026-02-03', N'Presente', NULL);
GO


CREATE TABLE [Auditoria_Asistencia] (
    [id_auditoria] INT PRIMARY KEY IDENTITY(1,1),
    [id_asistencia] INT,
    [id_estudiante] INT,
    [estado_registrado] NVARCHAR(255),
    [usuario_que_registro] NVARCHAR(255),
    [fecha_accion] DATETIME DEFAULT GETDATE()
);
GO