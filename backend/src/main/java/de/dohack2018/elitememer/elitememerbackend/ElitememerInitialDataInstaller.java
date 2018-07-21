package de.dohack2018.elitememer.elitememerbackend;

import de.dohack2018.elitememer.elitememerbackend.core.MemeService;
import de.dohack2018.elitememer.elitememerbackend.core.UserService;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.resource.ResourceResolver;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Component
public class ElitememerInitialDataInstaller implements
        ApplicationListener<ApplicationReadyEvent> {

    @Value("${memes.initial.file}")
    private transient String initialMemesListFile;

    @Autowired
    private transient ResourceLoader resourceLoader;

    @Autowired
    private transient UserService userService;

    @Autowired
    private transient MemeService memeService;

    @Override
    @Transactional
    public void onApplicationEvent(ApplicationReadyEvent event) {
        log.info("Installing initial data!!!");

        // dummy users
        final String[][] dummyUsersData = {
                {"xXx_ST4R_xXx", "https://i.imgur.com/donZM.jpg"},
                {"merkeldidnothingwrong", "https://i.imgur.com/UivaSCo.jpg"},
                {"eclipse > intellij", "https://i.imgur.com/Vknf19a.jpg"}
        };

        // Create Dummy Users
        List<User> dummyUsers = Arrays.stream(dummyUsersData).map(values -> {
            String name = values[0];
            String avatarImgurURL = values[1];

            return userService.createDummyUser(name, avatarImgurURL);
        }).collect(Collectors.toList());

        // Log
        log.info("Created dummy users.");
        dummyUsers.forEach(user -> log.info("Dummy user: " + user));

        // Initial Meme URLs
        List<String> initialMemeUrls = Collections.emptyList();
        Resource initialMemeListResource = resourceLoader.getResource(initialMemesListFile);
        try {
            initialMemeUrls = IOUtils.readLines(initialMemeListResource.getInputStream(), "UTF-8").stream().skip(1)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            throw new RuntimeException("Couldn't read initial memes file!", e);
        }

        // Save initial memes
        List<Meme> initialMemes = initialMemeUrls.stream().map(memeService::create).collect(Collectors.toList());

        // Log
        log.info("Imported " + initialMemes.size() + " initial memes!");
    }
}