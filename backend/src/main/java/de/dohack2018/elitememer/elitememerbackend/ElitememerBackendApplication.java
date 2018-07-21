package de.dohack2018.elitememer.elitememerbackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackageClasses = ElitememerBackendApplication.class)
@EnableAutoConfiguration
public class ElitememerBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(ElitememerBackendApplication.class, args);
	}
}
