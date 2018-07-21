package de.dohack2018.elitememer.elitememerbackend.web;

import lombok.NonNull;
import org.springframework.context.annotation.Primary;

public class PrimaryResourceNotFoundException extends Exception {
    public PrimaryResourceNotFoundException(@NonNull String message) {
        super(message);
    }
}
