package com.techelevator.controller;

import com.techelevator.dao.ExampleDAO;
import com.techelevator.model.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
public class ExampleController {

    @Autowired
    private ExampleDAO exampleDAO;

    @RequestMapping(path = "/examples", method = RequestMethod.GET)
    public List<Example> retrieveAllExamples() {

        return exampleDAO.retrieveAllExamples();

    }


}
