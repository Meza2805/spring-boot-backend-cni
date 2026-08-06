DELIMITER //

CREATE PROCEDURE sp_insertar_identidad_academica(
    IN p_id_estudiante INT,
    IN p_id_centro INT,
    IN p_carnet_codigo VARCHAR(255),
    OUT p_resultado VARCHAR(255)
)
BEGIN
    -- 1. Validar si el estudiante existe
    IF NOT EXISTS (SELECT 1 FROM `Estudiantes` WHERE `id_estudiante` = p_id_estudiante) THEN
        SET p_resultado = 'ERROR: El estudiante especificado no existe.';
    
    -- 2. Validar si el centro existe
    ELSEIF NOT EXISTS (SELECT 1 FROM `Centros` WHERE `id_centro` = p_id_centro) THEN
        SET p_resultado = 'ERROR: El centro especificado no existe.';
    
    -- 3. Validar si el carnet ya está asignado
    ELSEIF EXISTS (SELECT 1 FROM `Identidades_Academicas` WHERE `carnet_codigo` = p_carnet_codigo) THEN
        SET p_resultado = 'ERROR: El código de carnet ya está en uso.';
    
    ELSE
        INSERT INTO `Identidades_Academicas` (`id_estudiante`, `id_centro`, `carnet_codigo`)
        VALUES (p_id_estudiante, p_id_centro, p_carnet_codigo);
        
        SET p_resultado = 'OK: Identidad académica asignada exitosamente.';
    END IF;
END //

DELIMITER ;