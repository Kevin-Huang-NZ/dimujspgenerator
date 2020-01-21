package nz.co.dimu.jspgenerator;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import freemarker.template.TemplateExceptionHandler;

@Configuration
public class ApplicationContext {
	
	@Value("${generate.template.folder}")
	private String templateFolder;
	
	@Bean(name="freeMarkerCfg")
	public freemarker.template.Configuration freemarkerConfig() throws IOException { 
		freemarker.template.Configuration cfg = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_28);
        cfg.setDirectoryForTemplateLoading(new File(templateFolder));
//        cfg.setClassForTemplateLoading(this.getClass(), "templates");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setInterpolationSyntax(freemarker.template.Configuration.SQUARE_BRACKET_INTERPOLATION_SYNTAX);
        cfg.setLogTemplateExceptions(false);
        cfg.setOutputEncoding("UTF-8");
	    return cfg; 
	}
}
