package de.dohack2018.elitememer.elitememerbackend.web;

import com.coxautodev.graphql.tools.GraphQLResolver;
import de.dohack2018.elitememer.elitememerbackend.core.MatchingService;
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

    @Autowired
    private transient MatchingService matchingService;

    @Transactional(readOnly = true)
    public Double getSnobOrBobPercentage(User user, UUID viewerUserUuid) throws PrimaryResourceNotFoundException {
        User viewer = userService.findOne(viewerUserUuid).orElseThrow(() -> new PrimaryResourceNotFoundException
                ("Could not find Viewer with uuid '" + viewerUserUuid + "'."));
        return matchingService.getSnobOrBobPercentage(user, viewer);
    }

    @Transactional(readOnly = true)
    public Double getMatchPercentage(User user, UUID viewerUserUuid) throws PrimaryResourceNotFoundException {
        User viewer = userService.findOne(viewerUserUuid).orElseThrow(() -> new PrimaryResourceNotFoundException
                ("Could not find Viewer with uuid '" + viewerUserUuid + "'."));
        return matchingService.getSnobOrBobPercentage(user, viewer);
    }

    @Transactional(readOnly = true)
    public Double getEnemyPercentage(User user, UUID viewerUserUuid) throws PrimaryResourceNotFoundException {
        User viewer = userService.findOne(viewerUserUuid).orElseThrow(() -> new PrimaryResourceNotFoundException
                ("Could not find Viewer with uuid '" + viewerUserUuid + "'."));
        return matchingService.getEnemyPercentage(user, viewer);
    }

    @Transactional(readOnly = true)
    public List<Meme> getTopMemes(User user, UUID viewerUserUuid) throws PrimaryResourceNotFoundException {
        User viewer = userService.findOne(viewerUserUuid).orElseThrow(() -> new PrimaryResourceNotFoundException("Could not find Viewer with uuid '"+viewerUserUuid+"'."));
        return matchingService.getTopMemes(user, viewer);
    }

    @Transactional(readOnly = true)
    public List<Meme> getNextMemes(User user, int num) {
        return matchingService.getNextMemes(user, num);
    }

    @Transactional(readOnly = true)
    public List<User> getMatches(User user) {
        return matchingService.getMatches(user);
    }
}
