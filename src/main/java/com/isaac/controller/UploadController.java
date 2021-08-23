package com.isaac.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "C:\\storage";
		for(MultipartFile multipartFile : uploadFile) {
			log.info("---------------------------------------");
			log.info("Upload File Name : "+multipartFile.getOriginalFilename());
			log.info("Upload File Size : "+multipartFile.getSize());
			
			File savefile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(savefile);
			} catch (Exception e) {
				log.error(e.getMessage());
			} // end catch
		} // end for
	}
}
