package com.techelevator.dao;


import com.techelevator.model.Example;

import java.util.List;

public interface ExampleDAO {

    List<Example> retrieveAllExamples();

    void addExample(Example example);

    void deleteExample(int exampleId);

    void editExample(Example example);


}
