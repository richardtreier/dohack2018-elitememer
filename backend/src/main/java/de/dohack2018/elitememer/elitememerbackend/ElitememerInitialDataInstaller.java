package de.dohack2018.elitememer.elitememerbackend;

import de.dohack2018.elitememer.elitememerbackend.core.UserService;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Component
public class ElitememerInitialDataInstaller implements
        ApplicationListener<ApplicationReadyEvent> {

    @Autowired
    private transient UserService userService;

    @Override
    @Transactional
    public void onApplicationEvent(ApplicationReadyEvent event) {
        log.info("Installing initial data!!!");

        // dummy users
        final String[] dummyUsersData = {
                "xXx_ST4R_xXx",
                "merkeldidnothingwrong",
                "eclipse > intellij"
        };

        // Create Dummy Users
        List<User> dummyUsers = Arrays.stream(dummyUsersData).map(userService::createDummyUser).collect(Collectors.toList());

        // Log
        log.info("Created dummy users.");
        dummyUsers.forEach(user -> log.info("Dummy user: " + user));
    }
}