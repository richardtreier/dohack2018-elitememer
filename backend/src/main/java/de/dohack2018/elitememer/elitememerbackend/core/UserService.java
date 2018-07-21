package de.dohack2018.elitememer.elitememerbackend.core;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.Image;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.ImageRepository;
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

    @Autowired
    private transient ImageService imageService;

    @Transactional(readOnly = true)
    public List<User> findAll() {
        return userRepository.findAllByOrderByNameAsc();
    }

    @Transactional
    public User createDummyUser(@NonNull String name, @NonNull String avatarImgurURL) {
        // User
        User user = new User();
        user.setName(name);
        user.setAvatar(imageService.create(avatarImgurURL));

        return userRepository.save(user);
    }
}
