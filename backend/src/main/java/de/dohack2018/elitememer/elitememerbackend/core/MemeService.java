package de.dohack2018.elitememer.elitememerbackend.core;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.Image;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.ImageRepository;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.MemeRepository;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
public class MemeService {
    @Autowired
    private transient MemeRepository memeRepository;

    @Autowired
    private transient ImageService imageService;

    @Transactional(readOnly = true)
    public Optional<Meme> findOne(@NonNull UUID uuid) {
        return memeRepository.findOneByUuid(uuid);
    }

    @Transactional
    public Meme create(@NonNull String imgurUrl) {
        Meme meme = new Meme();
        meme.setImage(imageService.create(imgurUrl));

        return memeRepository.save(meme);
    }
}
