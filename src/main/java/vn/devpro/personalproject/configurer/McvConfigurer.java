package vn.devpro.personalproject.configurer;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import vn.devpro.personalproject.dto.NanaShopConstants;


@Configuration
public class McvConfigurer implements WebMvcConfigurer, NanaShopConstants{
	@Bean
	public ViewResolver viewResolver() {
		//Xu ly va tra ve doi tuong view thong qua ten
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setViewClass(JstlView.class);
		bean.setPrefix("/WEB-INF/views/");
		bean.setSuffix(".jsp");
		return bean;
	}

	//Dang ky thu muc chua resource file (css, js, img, ...)
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/frontend/**").addResourceLocations("classpath:/frontend/");
		registry.addResourceHandler("/backend/**").addResourceLocations("classpath:/backend/");
		registry.addResourceHandler("/FileUploads/**").addResourceLocations("file:" + FOLDER_UPLOAD);
	}

}
