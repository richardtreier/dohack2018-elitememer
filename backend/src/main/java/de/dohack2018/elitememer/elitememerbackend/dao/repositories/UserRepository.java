package de.dohack2018.elitememer.elitememerbackend.dao.repositories;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends AbstractBaseRepository<User> {
    List<User> findAllByOrderByNameAsc();
}
