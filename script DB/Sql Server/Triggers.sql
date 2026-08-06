CREATE TRIGGER trg_Auditoria_Asistencia_Insert
ON [Asistencia]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar en la bitácora leyendo la tabla temporal 'inserted'
    INSERT INTO [Auditoria_Asistencia] (
        [id_asistencia], 
        [id_estudiante], 
        [estado_registrado], 
        [usuario_que_registro]
    )
    SELECT 
        i.[id_asistencia],
        i.[id_estudiante],
        i.[estado],
        SUSER_SNAME() -- Captura el usuario actual de la base de datos
    FROM inserted i;
END;
GO


CREATE  TRIGGER trg_PrevenirModificacionAsistenciaAntigua
ON [Asistencia]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar si la fecha del registro que se intenta modificar tiene más de 7 días
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        WHERE DATEDIFF(DAY, d.[fecha], GETDATE()) > 7
    )
    BEGIN
        -- Revertir la transacción y lanzar error pedagógico
        RAISERROR (N'No es posible modificar registros de asistencia con más de 7 días de antigüedad.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO


CREATE TRIGGER trg_ProteccionEliminarEstudiante
ON [Estudiantes]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si alguno de los estudiantes a borrar tiene inscripciones registradas
    IF EXISTS (
        SELECT 1 
        FROM [Inscripciones] i
        INNER JOIN deleted d ON i.[id_estudiante] = d.[id_estudiante]
    )
    BEGIN
        RAISERROR (N'Operación cancelada: El estudiante tiene inscripciones asociadas y no se puede eliminar.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Si no tiene dependencias, procede con el borrado físico real
    DELETE FROM [Estudiantes]
    WHERE [id_estudiante] IN (SELECT [id_estudiante] FROM deleted);
    
    PRINT N'Estudiante eliminado correctamente.';
END;
GO