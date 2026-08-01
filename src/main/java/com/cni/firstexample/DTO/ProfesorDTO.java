package com.cni.firstexample.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProfesorDTO {
    private String nombre;
    private String especialidad;
    private String telefono;
}
