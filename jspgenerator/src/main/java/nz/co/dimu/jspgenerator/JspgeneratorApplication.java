package nz.co.dimu.jspgenerator;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages= {"nz.co.dimu.jspgenerator"})
@MapperScan("nz.co.dimu.jspgenerator.dao")
public class JspgeneratorApplication {

	public static void main(String[] args) {
		SpringApplication.run(JspgeneratorApplication.class, args);
	}

}

