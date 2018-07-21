package de.dohack2018.elitememer.elitememerbackend.dao.repositories;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface UserRepository extends AbstractBaseRepository<User> {
    List<User> findAllByOrderByNameAsc();
    List<User> findAllByUuidNot(UUID user);
}
