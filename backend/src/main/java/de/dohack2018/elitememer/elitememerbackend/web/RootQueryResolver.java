package de.dohack2018.elitememer.elitememerbackend.web;

import com.coxautodev.graphql.tools.GraphQLQueryResolver;
import de.dohack2018.elitememer.elitememerbackend.core.UserService;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
public class RootQueryResolver implements GraphQLQueryResolver {
    @Autowired
    private transient UserService userService;

    @Transactional(readOnly = true)
    public List<User> users() {
        return userService.findAll();
    }
}
