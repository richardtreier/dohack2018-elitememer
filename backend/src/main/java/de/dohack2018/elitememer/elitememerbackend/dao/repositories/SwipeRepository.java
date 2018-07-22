package de.dohack2018.elitememer.elitememerbackend.dao.repositories;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Swipe;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SwipeRepository extends AbstractBaseRepository<Swipe> {
    Optional<Swipe> findOneByMemeAndUser(Meme meme, User user);
}
