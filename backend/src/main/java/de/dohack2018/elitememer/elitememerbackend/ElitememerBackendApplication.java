package de.dohack2018.elitememer.elitememerbackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableAutoConfiguration
@EnableJpaRepositories
@EnableTransactionManagement
@SpringBootApplication(scanBasePackageClasses = ElitememerBackendApplication.class)
public class ElitememerBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(ElitememerBackendApplication.class, args);
	}
}
