package de.dohack2018.elitememer.elitememerbackend.core;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.Image;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.ImageRepository;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ImageService {
    @Autowired
    private transient ImageRepository imageRepository;

    @Transactional
    public Image create(@NonNull String imageImgurURL) {
        Image image = new Image();
        image.setImgurURL(imageImgurURL);
        return imageRepository.save(image);
    }
}
