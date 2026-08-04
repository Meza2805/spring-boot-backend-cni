package com.cni.firstexample;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing // <--- Activa la auditoría automática@EnableJpaAuditing // <--- Activa la auditoría automática
public class FirstexampleApplication {

    public static void main(String[] args) {
        SpringApplication.run(FirstexampleApplication.class, args);
    }

}