package de.dohack2018.elitememer.elitememerbackend.dao.entities;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.HashSet;
import java.util.Set;

@Entity
@Getter
@Setter
@RequiredArgsConstructor
@EqualsAndHashCode(callSuper = false, exclude = {"swipes"})
@ToString(exclude = {"swipes"})
public class User extends AbstractBaseEntity {
    @Column(unique = true)
    private String name;

    @ManyToOne(optional = false)
    private Image avatar;

    @OneToMany(mappedBy = "user")
    private Set<Swipe> swipes = new HashSet<>();
}