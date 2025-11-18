package com.example.myspringboot.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ScriptUtils;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@Component
public class DatabaseInitializer implements CommandLineRunner {

    @Autowired
    private DataSource dataSource;

    @Override
    public void run(String... args) throws Exception {
        try (Connection connection = dataSource.getConnection()) {
            // Check if database is empty by querying classic_book table
            boolean isEmpty = true;
            try (Statement statement = connection.createStatement()) {
                ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) FROM classic_book");
                if (resultSet.next()) {
                    isEmpty = resultSet.getInt(1) == 0;
                }
            } catch (SQLException e) {
                // Table may not exist yet
                isEmpty = true;
            }

            if (isEmpty) {
                // Execute the schema.sql script to create tables and insert test data
                ScriptUtils.executeSqlScript(connection, new ClassPathResource("schema.sql"));
                System.out.println("Database initialized successfully");
            } else {
                System.out.println("Database already contains data, skipping initialization");
            }
        } catch (SQLException e) {
            System.err.println("Failed to initialize database: " + e.getMessage());
            throw e;
        }
    }
}
