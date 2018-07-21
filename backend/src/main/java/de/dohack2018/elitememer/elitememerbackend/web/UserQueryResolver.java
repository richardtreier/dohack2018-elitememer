package de.dohack2018.elitememer.elitememerbackend.web;

import com.coxautodev.graphql.tools.GraphQLQueryResolver;
import de.dohack2018.elitememer.elitememerbackend.core.UserService;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Component
public class UserQueryResolver implements GraphQLQueryResolver {
    @Autowired
    private transient UserService userService;

    @Transactional(readOnly = true)
    public List<User> userList() {
        return userService.findAll();
    }

    @Transactional(readOnly = true)
    public User user(@NonNull UUID uuid) throws PrimaryResourceNotFoundException {
        return userService.findOne(uuid).orElseThrow(() -> new PrimaryResourceNotFoundException("Could not find user " +
                "with this uuid."));
    }
}
