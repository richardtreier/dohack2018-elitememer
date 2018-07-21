package de.dohack2018.elitememer.elitememerbackend.dao.entities;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
@Getter
@Setter
@RequiredArgsConstructor
@EqualsAndHashCode(callSuper = false)
@ToString
public class Swipe extends AbstractBaseEntity {
    @Column(nullable = false, name = "isLikeSwipe")
    private Boolean like;

    @ManyToOne(optional = false)
    private Meme meme;

    @ManyToOne(optional = false)
    private User user;
}
