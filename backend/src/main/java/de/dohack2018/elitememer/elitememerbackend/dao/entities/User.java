package de.dohack2018.elitememer.elitememerbackend.dao.entities;

import lombok.*;

import javax.persistence.Entity;

@Entity
@Getter
@Setter
@RequiredArgsConstructor
@EqualsAndHashCode(callSuper = false)
@ToString
public class User extends AbstractBaseEntity {
    private String name;
}
