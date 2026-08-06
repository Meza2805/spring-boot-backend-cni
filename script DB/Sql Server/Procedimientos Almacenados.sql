USE [RegistroAsistencia];
GO

-- =============================================
-- 1. SP INSERTAR CENTRO
-- Validación: Evita duplicar el nombre del centro.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarCentro
    @nombre_centro NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar si el centro ya existe
    IF EXISTS (SELECT 1 FROM [Centros] WHERE LOWER([nombre_centro]) = LOWER(@nombre_centro))
    BEGIN
        RAISERROR(N'El centro "%s" ya se encuentra registrado.', 16, 1, @nombre_centro);
        RETURN;
    END

    -- Inserción
    INSERT INTO [Centros] ([nombre_centro])
    VALUES (@nombre_centro);

    PRINT N'Centro registrado exitosamente.';
END;
GO

-- =============================================
-- 2. SP INSERTAR FACULTAD
-- Validación: Verifica que el Centro exista y evita facultades duplicadas en el mismo centro.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarFacultad
    @id_centro INT,
    @nombre_facultad NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Validar existencia de la llave foránea (Centro)
    IF NOT EXISTS (SELECT 1 FROM [Centros] WHERE [id_centro] = @id_centro)
    BEGIN
        RAISERROR(N'El centro especificado (ID: %d) no existe.', 16, 1, @id_centro);
        RETURN;
    END

    -- 2. Validar que la facultad no exista en el mismo centro
    IF EXISTS (SELECT 1 FROM [Facultades] WHERE [id_centro] = @id_centro AND LOWER([nombre_facultad]) = LOWER(@nombre_facultad))
    BEGIN
        RAISERROR(N'La facultad "%s" ya existe en este centro.', 16, 1, @nombre_facultad);
        RETURN;
    END

    -- Inserción
    INSERT INTO [Facultades] ([id_centro], [nombre_facultad])
    VALUES (@id_centro, @nombre_facultad);

    PRINT N'Facultad registrada exitosamente.';
END;
GO

-- =============================================
-- 3. SP INSERTAR CARRERA
-- Validación: Verifica que la Facultad exista y evita carreras duplicadas en la misma facultad.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarCarrera
    @id_facultad INT,
    @nombre_carrera NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Validar FK Facultad
    IF NOT EXISTS (SELECT 1 FROM [Facultades] WHERE [id_facultad] = @id_facultad)
    BEGIN
        RAISERROR(N'La facultad especificada (ID: %d) no existe.', 16, 1, @id_facultad);
        RETURN;
    END

    -- 2. Validar carrera duplicada en la misma facultad
    IF EXISTS (SELECT 1 FROM [Carreras] WHERE [id_facultad] = @id_facultad AND LOWER([nombre_carrera]) = LOWER(@nombre_carrera))
    BEGIN
        RAISERROR(N'La carrera "%s" ya existe en la facultad especificada.', 16, 1, @nombre_carrera);
        RETURN;
    END

    -- Inserción
    INSERT INTO [Carreras] ([id_facultad], [nombre_carrera])
    VALUES (@id_facultad, @nombre_carrera);

    PRINT N'Carrera registrada exitosamente.';
END;
GO

-- =============================================
-- 4. SP INSERTAR TURNO
-- Validación: Evita turnos duplicados por nombre.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarTurno
    @nombre_turno NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM [Turnos] WHERE LOWER([nombre_turno]) = LOWER(@nombre_turno))
    BEGIN
        RAISERROR(N'El turno "%s" ya existe.', 16, 1, @nombre_turno);
        RETURN;
    END

    INSERT INTO [Turnos] ([nombre_turno])
    VALUES (@nombre_turno);

    PRINT N'Turno registrado exitosamente.';
END;
GO

-- =============================================
-- 5. SP INSERTAR AÑO LECTIVO
-- Validación: Evita duplicar la etiqueta del año lectivo.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarAnioLectivo
    @etiqueta NVARCHAR(255),
    @activo BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM [Anios_Lectivos] WHERE LOWER([etiqueta]) = LOWER(@etiqueta))
    BEGIN
        RAISERROR(N'El año lectivo "%s" ya se encuentra registrado.', 16, 1, @etiqueta);
        RETURN;
    END

    INSERT INTO [Anios_Lectivos] ([etiqueta], [activo])
    VALUES (@etiqueta, @activo);

    PRINT N'Año lectivo registrado exitosamente.';
END;
GO

-- =============================================
-- 6. SP INSERTAR ASIGNATURA
-- Validación: Evita duplicados por nombre de asignatura.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarAsignatura
    @nombre_asignatura NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM [Asignaturas] WHERE LOWER([nombre_asignatura]) = LOWER(@nombre_asignatura))
    BEGIN
        RAISERROR(N'La asignatura "%s" ya existe.', 16, 1, @nombre_asignatura);
        RETURN;
    END

    INSERT INTO [Asignaturas] ([nombre_asignatura])
    VALUES (@nombre_asignatura);

    PRINT N'Asignatura registrada exitosamente.';
END;
GO

-- =============================================
-- 7. SP INSERTAR ESTUDIANTE
-- Validación: Previene registros duplicados mediante combinación de nombres y teléfono.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarEstudiante
    @p_nombre NVARCHAR(255),
    @s_nombre NVARCHAR(255) = NULL,
    @p_apellido NVARCHAR(255),
    @s_apellido NVARCHAR(255) = NULL,
    @sexo CHAR(1),
    @telefono NVARCHAR(255) = NULL,
    @direccion TEXT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar duplicidad por nombres, apellidos y teléfono (si se proporciona teléfono)
    IF EXISTS (
        SELECT 1 FROM [Estudiantes]
        WHERE LOWER([p_nombre]) = LOWER(@p_nombre)
          AND LOWER([p_apellido]) = LOWER(@p_apellido)
          AND (@telefono IS NOT NULL AND [telefono] = @telefono)
    )
    BEGIN
        RAISERROR(N'El estudiante ya existe registrado con el mismo teléfono.', 16, 1);
        RETURN;
    END

    INSERT INTO [Estudiantes] ([p_nombre], [s_nombre], [p_apellido], [s_apellido], [sexo], [telefono], [direccion])
    VALUES (@p_nombre, @s_nombre, @p_apellido, @s_apellido, @sexo, @telefono, @direccion);

    PRINT N'Estudiante registrado exitosamente.';
END;
GO

-- =============================================
-- 8. SP INSERTAR IDENTIDAD ACADÉMICA
-- Validación: Verifica existencia de Estudiante y Centro, y previene duplicar el código de carnet.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarIdentidadAcademica
    @id_estudiante INT,
    @id_centro INT,
    @carnet_codigo NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Validar FK Estudiante
    IF NOT EXISTS (SELECT 1 FROM [Estudiantes] WHERE [id_estudiante] = @id_estudiante)
    BEGIN
        RAISERROR(N'El estudiante especificado (ID: %d) no existe.', 16, 1, @id_estudiante);
        RETURN;
    END

    -- 2. Validar FK Centro
    IF NOT EXISTS (SELECT 1 FROM [Centros] WHERE [id_centro] = @id_centro)
    BEGIN
        RAISERROR(N'El centro especificado (ID: %d) no existe.', 16, 1, @id_centro);
        RETURN;
    END

    -- 3. Validar carnet único
    IF EXISTS (SELECT 1 FROM [Identidades_Academicas] WHERE LOWER([carnet_codigo]) = LOWER(@carnet_codigo))
    BEGIN
        RAISERROR(N'El código de carnet "%s" ya está asignado.', 16, 1, @carnet_codigo);
        RETURN;
    END

    INSERT INTO [Identidades_Academicas] ([id_estudiante], [id_centro], [carnet_codigo])
    VALUES (@id_estudiante, @id_centro, @carnet_codigo);

    PRINT N'Identidad académica asignada exitosamente.';
END;
GO

-- =============================================
-- 9. SP INSERTAR GRUPO
-- Validación: Verifica FKs (Carrera, Turno, Año) y evita nombre de grupo duplicado en la misma carrera y año.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarGrupo
    @id_carrera INT,
    @nombre_grupo NVARCHAR(255),
    @id_turno INT,
    @id_anio INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar FKs
    IF NOT EXISTS (SELECT 1 FROM [Carreras] WHERE [id_carrera] = @id_carrera)
    BEGIN
        RAISERROR(N'La carrera especificada (ID: %d) no existe.', 16, 1, @id_carrera);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM [Turnos] WHERE [id_turno] = @id_turno)
    BEGIN
        RAISERROR(N'El turno especificado (ID: %d) no existe.', 16, 1, @id_turno);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM [Anios_Lectivos] WHERE [id_anio] = @id_anio)
    BEGIN
        RAISERROR(N'El año lectivo especificado (ID: %d) no existe.', 16, 1, @id_anio);
        RETURN;
    END

    -- Validar duplicidad
    IF EXISTS (
        SELECT 1 FROM [Grupos] 
        WHERE [id_carrera] = @id_carrera 
          AND [id_anio] = @id_anio 
          AND LOWER([nombre_grupo]) = LOWER(@nombre_grupo)
    )
    BEGIN
        RAISERROR(N'El grupo "%s" ya existe para la carrera y año lectivo seleccionados.', 16, 1, @nombre_grupo);
        RETURN;
    END

    INSERT INTO [Grupos] ([id_carrera], [nombre_grupo], [id_turno], [id_anio])
    VALUES (@id_carrera, @nombre_grupo, @id_turno, @id_anio);

    PRINT N'Grupo creado exitosamente.';
END;
GO

-- =============================================
-- 10. SP INSERTAR HORARIO
-- Validación: Verifica FKs y previene cruce/duplicado de horario (mismo grupo, mismo día y hora inicio).
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarHorario
    @id_grupo INT,
    @id_asignatura INT,
    @dia_semana NVARCHAR(255),
    @hora_inicio TIME,
    @hora_fin TIME,
    @aula NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar FKs
    IF NOT EXISTS (SELECT 1 FROM [Grupos] WHERE [id_group] = @id_grupo)
    BEGIN
        RAISERROR(N'El grupo especificado (ID: %d) no existe.', 16, 1, @id_grupo);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM [Asignaturas] WHERE [id_asignatura] = @id_asignatura)
    BEGIN
        RAISERROR(N'La asignatura especificada (ID: %d) no existe.', 16, 1, @id_asignatura);
        RETURN;
    END

    -- Validar cruce de horarios para el mismo grupo y día
    IF EXISTS (
        SELECT 1 FROM [Horarios]
        WHERE [id_grupo] = @id_grupo
          AND LOWER([dia_semana]) = LOWER(@dia_semana)
          AND (@hora_inicio < [hora_fin] AND @hora_fin > [hora_inicio])
    )
    BEGIN
        RAISERROR(N'Existe un solapamiento/cruce de horario para este grupo en el día especificado.', 16, 1);
        RETURN;
    END

    INSERT INTO [Horarios] ([id_grupo], [id_asignatura], [dia_semana], [hora_inicio], [hora_fin], [aula])
    VALUES (@id_grupo, @id_asignatura, @dia_semana, @hora_inicio, @hora_fin, @aula);

    PRINT N'Horario registrado exitosamente.';
END;
GO

-- =============================================
-- 11. SP INSERTAR INSCRIPCIÓN
-- Validación: Verifica FKs y evita que un estudiante se inscriba dos veces en el mismo grupo.
-- =============================================
CREATE OR ALTER PROCEDURE sp_InsertarInscripcion
    @id_estudiante INT,
    @id_grupo INT,
    @fecha_inscripcion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Usar fecha actual si no se proporciona una
    IF @fecha_inscripcion IS NULL
        SET @fecha_inscripcion = CAST(GETDATE() AS DATE);

    -- Validar FKs
    IF NOT EXISTS (SELECT 1 FROM [Estudiantes] WHERE [id_estudiante] = @id_estudiante)
    BEGIN
        RAISERROR(N'El estudiante especificado (ID: %d) no existe.', 16, 1, @id_estudiante);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM [Grupos] WHERE [id_group] = @id_grupo)
    BEGIN
        RAISERROR(N'El grupo especificado (ID: %d) no existe.', 16, 1, @id_grupo);
        RETURN;
    END

    -- Validar inscripción única
    IF EXISTS (SELECT 1 FROM [Inscripciones] WHERE [id_estudiante] = @id_estudiante AND [id_grupo] = @id_grupo)
    BEGIN
        RAISERROR(N'El estudiante ya se encuentra inscrito en este grupo.', 16, 1);
        RETURN;
    END

    INSERT INTO [Inscripciones] ([id_estudiante], [id_grupo], [fecha_inscripcion])
    VALUES (@id_estudiante, @id_grupo, @fecha_inscripcion);

    PRINT N'Inscripción realizada exitosamente.';
END;
GO

-- =============================================
-- 12. SP REGISTRAR ASISTENCIA
-- Validación: Verifica FKs y previene doble registro de asistencia para la misma sesión/fecha.
-- =============================================
CREATE OR ALTER PROCEDURE sp_RegistrarAsistencia
    @id_estudiante INT,
    @id_horario INT,
    @fecha DATE,
    @estado NVARCHAR(255),
    @observaciones TEXT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar FKs
    IF NOT EXISTS (SELECT 1 FROM [Estudiantes] WHERE [id_estudiante] = @id_estudiante)
    BEGIN
        RAISERROR(N'El estudiante especificado (ID: %d) no existe.', 16, 1, @id_estudiante);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM [Horarios] WHERE [id_horario] = @id_horario)
    BEGIN
        RAISERROR(N'El horario especificado (ID: %d) no existe.', 16, 1, @id_horario);
        RETURN;
    END

    -- Validar que no se duplique la toma de asistencia en el mismo día y horario
    IF EXISTS (
        SELECT 1 FROM [Asistencia] 
        WHERE [id_estudiante] = @id_estudiante 
          AND [id_horario] = @id_horario 
          AND [fecha] = @fecha
    )
    BEGIN
        RAISERROR(N'Ya se ha tomado asistencia para este estudiante en la fecha y horario indicados.', 16, 1);
        RETURN;
    END

    INSERT INTO [Asistencia] ([id_estudiante], [id_horario], [fecha], [estado], [observaciones])
    VALUES (@id_estudiante, @id_horario, @fecha, @estado, @observaciones);

    PRINT N'Asistencia registrada exitosamente.';
END;
GO