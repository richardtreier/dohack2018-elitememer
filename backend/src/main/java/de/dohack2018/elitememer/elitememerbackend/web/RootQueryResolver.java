package de.dohack2018.elitememer.elitememerbackend.web;

import com.coxautodev.graphql.tools.GraphQLQueryResolver;
import graphql.servlet.GraphQLQueryProvider;
import org.springframework.stereotype.Component;

@Component
public class RootQueryResolver implements GraphQLQueryResolver {
    public String helloWorld() {
        return "Hello World!";
    }
}
