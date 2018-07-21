package de.dohack2018.elitememer.elitememerbackend.web;

import com.coxautodev.graphql.tools.GraphQLMutationResolver;
import com.coxautodev.graphql.tools.GraphQLQueryResolver;
import de.dohack2018.elitememer.elitememerbackend.core.LikeOrDislikeService;
import de.dohack2018.elitememer.elitememerbackend.core.MemeService;
import de.dohack2018.elitememer.elitememerbackend.core.UserService;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Component
public class LikeOrDislikeMutationResolver implements GraphQLMutationResolver {
    @Autowired
    private transient LikeOrDislikeService likeOrDislikeService;

    @Autowired
    private transient UserService userService;

    @Autowired
    private transient MemeService memeService;

    @Transactional
    public boolean likeOrDislikeMeme(boolean like, UUID memeUuid, UUID userUuid) throws
            PrimaryResourceNotFoundException {
        // Resolve User
        User user = userService.findOne(userUuid).orElseThrow(() -> new PrimaryResourceNotFoundException("Could not " +
                "find User with given uuid."));

        // Resolve Meme
        Meme meme = memeService.findOne(memeUuid).orElseThrow(() -> new PrimaryResourceNotFoundException("Could not " +
                "find Meme with given uuid."));

        // Do our stuff
        likeOrDislikeService.likeOrDislikeMeme(like, meme, user);

        // Result
        return true;
    }
}
