package de.dohack2018.elitememer.elitememerbackend.core;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.Image;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Swipe;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.ImageRepository;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.SwipeRepository;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LikeOrDislikeService {
    @Autowired
    private transient SwipeRepository swipeRepository;

    @Transactional
    public void likeOrDislikeMeme(boolean like, @NonNull Meme meme, @NonNull User user) {
        Swipe swipe = new Swipe();

        swipe.setLike(like);
        swipe.setMeme(meme);
        swipe.setUser(user);

        swipeRepository.save(swipe);
    }
}
