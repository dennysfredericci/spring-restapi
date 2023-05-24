package br.com.fredericci.springrestapi;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String get() {
        return "Hello World!";
    }

}
