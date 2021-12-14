package com.techelevator.controller;

import com.techelevator.dao.ExampleDAO;
import com.techelevator.dao.UserDAO;
import com.techelevator.model.Example;
import com.techelevator.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.sql.SQLOutput;
import java.util.List;

@RestController
@CrossOrigin
public class ExampleController {

    @Autowired
    private ExampleDAO exampleDAO;
    @Autowired
    private UserDAO userDAO;

    @RequestMapping(path = "/examples", method = RequestMethod.GET)
    public List<Example> retrieveAllExamples(Principal user) {
        int userId = 0;
        try {
            userId = userDAO.findIdByUsername(user.getName());
        }
        catch (Exception ex) {

        }
        return exampleDAO.retrieveAllExamples(userId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PreAuthorize("hasRole('ROLE_USER')")
    @RequestMapping(path = "/examples", method = RequestMethod.POST)
    public void addExample(@RequestBody Example example, Principal user) {
        example.setUserId(userDAO.findIdByUsername(user.getName()));
        exampleDAO.addExample(example);

    }

    @ResponseStatus(HttpStatus.OK)
    @PreAuthorize("hasRole('ROLE_USER')")
    @RequestMapping(path =  "/examples/{exampleId}/favorite", method = RequestMethod.PUT)
    public void toggleFavorite(@PathVariable int exampleId){
        exampleDAO.toggleFavorite(exampleId);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @PreAuthorize("hasRole('ROLE_USER')")
    @RequestMapping(path = "/examples/{exampleId}", method = RequestMethod.DELETE)
    public void deleteExample(@PathVariable int exampleId) {
        exampleDAO.deleteExample(exampleId);
    }

    @ResponseStatus(HttpStatus.OK)
    @PreAuthorize("hasRole('ROLE_USER')")
    @RequestMapping(path = "/examples/{exampleId}", method = RequestMethod.PUT)
    public void editExample(@RequestBody Example example, @PathVariable int exampleId, Principal user) {
        example.setExampleId(exampleId);

        exampleDAO.editExample(example);
    }


}
