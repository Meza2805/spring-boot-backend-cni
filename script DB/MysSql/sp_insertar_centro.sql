DELIMITER //

CREATE PROCEDURE sp_insertar_centro(
    IN p_nombre_centro VARCHAR(255),
    OUT p_resultado VARCHAR(255)
)
BEGIN
    -- Validar si el centro ya existe
    IF EXISTS (SELECT 1 FROM `Centros` WHERE LOWER(`nombre_centro`) = LOWER(p_nombre_centro)) THEN
        SET p_resultado = 'ERROR: El centro ya se encuentra registrado.';
    ELSE
        INSERT INTO `Centros` (`nombre_centro`)
        VALUES (p_nombre_centro);
        
        SET p_resultado = 'OK: Centro registrado exitosamente.';
    END IF;
END //

DELIMITER ;