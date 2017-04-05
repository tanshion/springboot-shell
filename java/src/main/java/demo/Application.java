package demo;

import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.system.ApplicationPidFileWriter;

@SpringBootApplication
public class Application {

	public static void main(final String[] args) {
		SpringApplication application = new SpringApplicationBuilder()//
				.sources(Application.class)//
				.registerShutdownHook(true)//
				.bannerMode(Banner.Mode.CONSOLE)//
				.build();
		application.addListeners(new ApplicationPidFileWriter("demo.pid"));
		application.run(args);
	}

}
