DELIMITER //

CREATE PROCEDURE sp_insertar_inscripcion(
    IN p_id_estudiante INT,
    IN p_id_grupo INT,
    IN p_fecha_inscripcion DATE,
    OUT p_resultado VARCHAR(255)
)
BEGIN
    -- 1. Validar que el estudiante exista
    IF NOT EXISTS (SELECT 1 FROM `Estudiantes` WHERE `id_estudiante` = p_id_estudiante) THEN
        SET p_resultado = 'ERROR: El estudiante no existe.';
        
    -- 2. Validar que el grupo exista
    ELSEIF NOT EXISTS (SELECT 1 FROM `Grupos` WHERE `id_group` = p_id_grupo) THEN
        SET p_resultado = 'ERROR: El grupo no existe.';
        
    -- 3. Validar si ya está inscrito en ese grupo
    ELSEIF EXISTS (SELECT 1 FROM `Inscripciones` WHERE `id_estudiante` = p_id_estudiante AND `id_grupo` = p_id_grupo) THEN
        SET p_resultado = 'ERROR: El estudiante ya se encuentra inscrito en este grupo.';
        
    ELSE
        INSERT INTO `Inscripciones` (`id_estudiante`, `id_grupo`, `fecha_inscripcion`)
        VALUES (p_id_estudiante, p_id_grupo, COALESCE(p_fecha_inscripcion, CURDATE()));
        
        SET p_resultado = 'OK: Inscripción realizada exitosamente.';
    END IF;
END //

DELIMITER ;