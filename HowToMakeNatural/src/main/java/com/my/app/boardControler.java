package com.my.app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class boardControler {
	@RequestMapping(value = "/blog/main", method = RequestMethod.GET)
	public String getBoardList(Model model) throws Exception {
	    
	    return "/blog/main";
	}
}
