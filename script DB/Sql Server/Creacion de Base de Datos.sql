
--CREATE DATABASE RegistroAsistencia;
--USE RegistroAsistencia;

CREATE TABLE [Centros] (
  [id_centro] integer PRIMARY KEY IDENTITY(1, 1),
  [nombre_centro] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Facultades] (
  [id_facultad] integer PRIMARY KEY IDENTITY(1, 1),
  [id_centro] integer,
  [nombre_facultad] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Carreras] (
  [id_carrera] integer PRIMARY KEY IDENTITY(1, 1),
  [id_facultad] integer,
  [nombre_carrera] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Turnos] (
  [id_turno] integer PRIMARY KEY IDENTITY(1, 1),
  [nombre_turno] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [Anios_Lectivos] (
  [id_anio] integer PRIMARY KEY IDENTITY(1, 1),
  [etiqueta] nvarchar(255) UNIQUE NOT NULL,
  [activo] BIT DEFAULT (0)
)
GO

CREATE TABLE [Asignaturas] (
  [id_asignatura] integer PRIMARY KEY IDENTITY(1, 1),
  [nombre_asignatura] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Estudiantes] (
  [id_estudiante] integer PRIMARY KEY IDENTITY(1, 1),
  [p_nombre] nvarchar(255) NOT NULL,
  [s_nombre] nvarchar(255),
  [p_apellido] nvarchar(255) NOT NULL,
  [s_apellido] nvarchar(255),
  [sexo] char(1),
  [telefono] nvarchar(255),
  [direccion] text
)
GO

CREATE TABLE [Identidades_Academicas] (
  [id_identidad] integer PRIMARY KEY IDENTITY(1, 1),
  [id_estudiante] integer,
  [id_centro] integer,
  [carnet_codigo] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Grupos] (
  [id_group] integer PRIMARY KEY IDENTITY(1, 1),
  [id_carrera] integer,
  [nombre_grupo] nvarchar(255),
  [id_turno] integer,
  [id_anio] integer
)
GO

CREATE TABLE [Horarios] (
  [id_horario] integer PRIMARY KEY IDENTITY(1, 1),
  [id_grupo] integer,
  [id_asignatura] integer,
  [dia_semana] nvarchar(255),
  [hora_inicio] time,
  [hora_fin] time,
  [aula] nvarchar(255)
)
GO

CREATE TABLE [Inscripciones] (
  [id_inscripcion] integer PRIMARY KEY IDENTITY(1, 1),
  [id_estudiante] integer,
  [id_grupo] integer,
  [fecha_inscripcion] date
)
GO

CREATE TABLE [Asistencia] (
  [id_asistencia] integer PRIMARY KEY IDENTITY(1, 1),
  [id_estudiante] integer,
  [id_horario] integer,
  [fecha] date,
  [estado] nvarchar(255),
  [observaciones] text
)
GO

ALTER TABLE [Facultades] ADD FOREIGN KEY ([id_centro]) REFERENCES [Centros] ([id_centro])
GO

ALTER TABLE [Carreras] ADD FOREIGN KEY ([id_facultad]) REFERENCES [Facultades] ([id_facultad])
GO

ALTER TABLE [Identidades_Academicas] ADD FOREIGN KEY ([id_estudiante]) REFERENCES [Estudiantes] ([id_estudiante])
GO

ALTER TABLE [Identidades_Academicas] ADD FOREIGN KEY ([id_centro]) REFERENCES [Centros] ([id_centro])
GO

ALTER TABLE [Grupos] ADD FOREIGN KEY ([id_carrera]) REFERENCES [Carreras] ([id_carrera])
GO

ALTER TABLE [Grupos] ADD FOREIGN KEY ([id_turno]) REFERENCES [Turnos] ([id_turno])
GO

ALTER TABLE [Grupos] ADD FOREIGN KEY ([id_anio]) REFERENCES [Anios_Lectivos] ([id_anio])
GO

ALTER TABLE [Horarios] ADD FOREIGN KEY ([id_grupo]) REFERENCES [Grupos] ([id_group])
GO

ALTER TABLE [Horarios] ADD FOREIGN KEY ([id_asignatura]) REFERENCES [Asignaturas] ([id_asignatura])
GO

ALTER TABLE [Inscripciones] ADD FOREIGN KEY ([id_estudiante]) REFERENCES [Estudiantes] ([id_estudiante])
GO

ALTER TABLE [Inscripciones] ADD FOREIGN KEY ([id_grupo]) REFERENCES [Grupos] ([id_group])
GO

ALTER TABLE [Asistencia] ADD FOREIGN KEY ([id_estudiante]) REFERENCES [Estudiantes] ([id_estudiante])
GO

ALTER TABLE [Asistencia] ADD FOREIGN KEY ([id_horario]) REFERENCES [Horarios] ([id_horario])
GO
