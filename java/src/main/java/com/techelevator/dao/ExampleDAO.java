package com.techelevator.dao;


import com.techelevator.model.Example;
import com.techelevator.model.User;

import java.security.Principal;
import java.util.List;

public interface ExampleDAO {

    List<Example> retrieveAllExamples(int userId);

    void addExample(Example example);

    void deleteExample(int exampleId);

    void editExample(Example example);


}
