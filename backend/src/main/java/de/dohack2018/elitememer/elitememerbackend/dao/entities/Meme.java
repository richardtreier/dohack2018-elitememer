package de.dohack2018.elitememer.elitememerbackend.dao.entities;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import java.util.HashSet;
import java.util.Set;

@Entity
@Getter
@Setter
@RequiredArgsConstructor
@EqualsAndHashCode(callSuper = false, exclude = {"swipes"})
@ToString(exclude = {"swipes"})
public class Meme extends AbstractBaseEntity {
    @OneToOne
    private Image image;

    @OneToMany(mappedBy = "user")
    private Set<Swipe> swipes = new HashSet<>();
}
