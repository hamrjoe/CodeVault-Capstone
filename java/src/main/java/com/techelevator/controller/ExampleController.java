package com.techelevator.controller;

import com.techelevator.dao.ExampleDAO;
import com.techelevator.model.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

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

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/examples", method = RequestMethod.POST)
    public void addExample(@RequestBody Example example) {
        exampleDAO.addExample(example);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path = "/examples/{exampleId}", method = RequestMethod.DELETE)
    public void deleteExample(@PathVariable int exampleId) {
        exampleDAO.deleteExample(exampleId);
    }
    @RequestMapping(path = "/examples/{exampleId}", method = RequestMethod.PUT)
    public void editExample(@RequestBody Example example, @PathVariable int exampleId) {
        example.setExampleId(exampleId);
        exampleDAO.editExample(example);
    }


}
