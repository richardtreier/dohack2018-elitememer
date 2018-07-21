package de.dohack2018.elitememer.elitememerbackend.dao.repositories;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface MemeRepository extends AbstractBaseRepository<Meme> {

    //@Query("SELECT meme FROM Meme meme JOIN meme.swipe swipe WHERE swipe IS NULL OR (swipe.user <> :user)")
    //findUnswipedMemesByUser(User user);

    Set<Meme> findAllBySwipesIsEmptyOrSwipes_UserNot(User user);
}
