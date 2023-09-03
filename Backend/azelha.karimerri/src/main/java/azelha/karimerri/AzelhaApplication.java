package azelha.karimerri;

import java.io.IOException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackageClasses = { AzelhaApplication.class })
@ComponentScan(basePackages = { "azelha.karimerri.*" })
@EnableJpaRepositories("azelha.karimerri.repos")
public class AzelhaApplication {

	public static void main(String[] args) throws IOException {
		SpringApplication.run(AzelhaApplication.class, args);
	}

}
