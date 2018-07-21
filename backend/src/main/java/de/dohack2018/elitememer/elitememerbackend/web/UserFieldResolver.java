package de.dohack2018.elitememer.elitememerbackend.web;

import com.coxautodev.graphql.tools.GraphQLResolver;
import com.google.common.collect.Lists;
import de.dohack2018.elitememer.elitememerbackend.core.UserService;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

@Component
public class UserFieldResolver implements GraphQLResolver<User> {
    @Autowired
    private transient UserService userService;

    @Transactional(readOnly = true)
    public Double getSnobOrBobPercentage(User user, UUID viewerUserUuid) {
        return 0.2;
    }

    @Transactional(readOnly = true)
    public Double getMatchPercentage(User user, UUID viewerUserUuid) {
        return 0.92;
    }

    @Transactional(readOnly = true)
    public Double getEnemyPercentage(User user, UUID viewerUserUuid) {
        return 0.3;
    }

    @Transactional(readOnly = true)
    public List<Meme> getTopMemes(User user, UUID viewerUserUuid) {
        return Collections.emptyList();
    }

    @Transactional(readOnly = true)
    public List<Meme> getNextMemes(User user, int num) {
        return Collections.emptyList();
    }

    @Transactional(readOnly = true)
    public List<User> getMatches(User user) {
        return Collections.emptyList();
    }
}
