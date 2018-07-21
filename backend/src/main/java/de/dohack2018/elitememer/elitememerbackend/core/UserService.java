package de.dohack2018.elitememer.elitememerbackend.core;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.UserRepository;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private transient UserRepository userRepository;

    @Transactional(readOnly = true)
    public List<User> findAll() {
        return userRepository.findAllByOrderByNameAsc();
    }

    @Transactional
    public User createDummyUser(@NonNull String name) {
        User user = new User();
        user.setName(name);

        return userRepository.save(user);
    }
}
