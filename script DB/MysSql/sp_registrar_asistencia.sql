DELIMITER //

CREATE PROCEDURE sp_registrar_asistencia(
    IN p_id_estudiante INT,
    IN p_id_horario INT,
    IN p_fecha DATE,
    IN p_estado VARCHAR(255),
    IN p_observaciones TEXT,
    OUT p_resultado VARCHAR(255)
)
BEGIN
    -- 1. Validar existencia del horario
    IF NOT EXISTS (SELECT 1 FROM `Horarios` WHERE `id_horario` = p_id_horario) THEN
        SET p_resultado = 'ERROR: El horario especificado no existe.';
        
    -- 2. Validar que la asistencia no se haya tomado ya hoy/en esa fecha
    ELSEIF EXISTS (
        SELECT 1 FROM `Asistencia` 
        WHERE `id_estudiante` = p_id_estudiante 
          AND `id_horario` = p_id_horario 
          AND `fecha` = p_fecha
    ) THEN
        SET p_resultado = 'ERROR: Ya existe un registro de asistencia para este estudiante en esta fecha y horario.';
        
    ELSE
        INSERT INTO `Asistencia` (`id_estudiante`, `id_horario`, `fecha`, `estado`, `observaciones`)
        VALUES (p_id_estudiante, p_id_horario, p_fecha, p_estado, p_observaciones);
        
        SET p_resultado = 'OK: Asistencia registrada correctamente.';
    END IF;
END //

DELIMITER ;