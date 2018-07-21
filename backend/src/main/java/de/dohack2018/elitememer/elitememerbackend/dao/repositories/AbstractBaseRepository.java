package de.dohack2018.elitememer.elitememerbackend.dao.repositories;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.AbstractBaseEntity;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.Optional;
import java.util.UUID;

@NoRepositoryBean
public interface AbstractBaseRepository<T extends AbstractBaseEntity> extends JpaRepository<T, UUID>,
        CrudRepository<T, UUID>, JpaSpecificationExecutor<T> {
    Optional<T> findOneByUuid(UUID uuid);
}
