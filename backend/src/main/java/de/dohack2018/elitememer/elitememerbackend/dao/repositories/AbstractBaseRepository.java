package de.dohack2018.elitememer.elitememerbackend.dao.repositories;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.AbstractBaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.UUID;

@NoRepositoryBean
public interface AbstractBaseRepository<T extends AbstractBaseEntity> extends JpaRepository<T, UUID> {
}
