package com.techelevator.dao;

import com.techelevator.model.Example;


import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;


@Component
public class JDBCExampleDAO implements ExampleDAO{

    private JdbcTemplate jdbcTemplate;

    public JDBCExampleDAO(DataSource dataSource) {

        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }


    @Override
    public List<Example> retrieveAllExamples() {

        List<Example> examples = new ArrayList();

        String sql = "SELECT * FROM examples";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);

        while (results.next()) {
            examples.add(mapRowToExample(results));
        }

        return examples;
    }


    private Example mapRowToExample(SqlRowSet results) {

        Example example = new Example();

        example.setTitle(results.getString("title"));
        //example.setTags(results.get);
        example.setExampleId(results.getLong("example_id"));
        //example.setLanguageName(results.getString(""));
        example.setCodeExample(results.getString("code_example"));
        example.setPrivate(results.getBoolean("is_private"));
        example.setAttribution(results.getString("attribution"));
        //example.setUserId(results.get);
        example.setDefault(results.getBoolean("is_default"));

        return example;

    }

}
