package de.dohack2018.elitememer.elitememerbackend.core;

import de.dohack2018.elitememer.elitememerbackend.dao.entities.Meme;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.Swipe;
import de.dohack2018.elitememer.elitememerbackend.dao.entities.User;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.MemeRepository;
import de.dohack2018.elitememer.elitememerbackend.dao.repositories.UserRepository;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.function.BiFunction;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class MatchingService {
    @Autowired
    private transient MemeRepository memeRepository;

    @Autowired
    private transient UserRepository userRepository;

    /**
     * Calculate: SnobOrBob Percentage
     *
     * @param user
     * @param viewer
     * @return
     */
    @Transactional(readOnly = true)
    public double getSnobOrBobPercentage(@NonNull User user, @NonNull User viewer) {
        long numLikes = user.getSwipes().stream().filter(swipe -> !swipe.getLike()).count();
        long numTotal = user.getSwipes().size();

        if (numLikes == 0 && numTotal == 0) {
            return 0.5;
        }

        if (numTotal == 0) {
            return 1;
        }

        return (double) numLikes / (double) numTotal;
    }

    /**
     * Calculation: Match Percentage
     *
     * @param user
     * @param viewer
     * @return
     */
    @Transactional(readOnly = true)
    public double getMatchPercentage(@NonNull User user, @NonNull User viewer) {
        long numAgreements = agreements(user, viewer).count();
        long numCommonSwipes = commonSwipes(user, viewer).count();

        if (numCommonSwipes == 0) {
            return 0;
        }

        return numAgreements / numCommonSwipes;
    }

    /**
     * Calculation: Enemy Percentage
     *
     * @param user
     * @param viewer
     * @return
     */
    @Transactional(readOnly = true)
    public double getEnemyPercentage(@NonNull User user, @NonNull User viewer) {
        long numDisagreements = disagreements(user, viewer).count();
        long numCommonSwipes = commonSwipes(user, viewer).count();

        if (numCommonSwipes == 0) {
            return 0;
        }

        return numDisagreements / numCommonSwipes;
    }

    /**
     * Calculation: "Top Memes" for a user from another users perspective
     *
     * @param user
     * @param viewer
     * @return
     */
    @Transactional(readOnly = true)
    public List<Meme> getTopMemes(@NonNull User user, @NonNull User viewer) {
        // Get liked, unseen memes of user, add other liked, seen memes

        Set<Swipe> userSwipes = user.getSwipes();
        Set<Swipe> viewerSwipes = viewer.getSwipes();

        // Get liked, unseen memes of user for viewer
        Set<Meme> userLikes = userSwipes.stream()
                // Filter by isLiked && is not disliked by viewer
                .filter(userSwipe ->
                        // isLiked
                        userSwipe.getLike() &&
                                //isNotDisliked
                                viewerSwipes.stream()
                                        .noneMatch(viewerSwipe -> !viewerSwipe.getLike() && viewerSwipe.getMeme()
                                                .getUuid().equals(userSwipe.getMeme().getUuid())))
                // Map to memes
                .map(Swipe::getMeme)
                .collect(Collectors.toSet());

        // Partition by whether the meme is unknown to the viewer
        Map<Boolean, List<Meme>> userLikesByIsUnknown = userLikes.stream().collect(Collectors.partitioningBy(userLike ->
                viewerSwipes.stream().noneMatch(viewerSwipe -> viewerSwipe.getMeme().getUuid().equals(userLike
                        .getUuid()))));

        // Make a list of lists to ensure order
        List<List<Meme>> memeListsInOrder = Arrays.asList(
                // First the unknown memes
                userLikesByIsUnknown.getOrDefault(true, Collections.emptyList()),

                // Then the known memes, so it's not empty
                userLikesByIsUnknown.getOrDefault(false, Collections.emptyList())
        );

        // Return Meme List
        return memeListsInOrder.stream().flatMap(Collection::stream).collect(Collectors.toList());
    }

    /**
     * Calculation: "Next memes" to be shown to a user
     *
     * @param user
     * @param num  Number of Memes to return
     */
    @Transactional(readOnly = true)
    public List<Meme> getNextMemes(@NonNull User user, int num) {
        // Get unseen memes, shuffled
        Set<Meme> unseenMemes = memeRepository.findAllBySwipesIsEmptyOrSwipes_UserNot(user);
        List<Meme> unseenMemesShuffled = new ArrayList<Meme>(unseenMemes);
        Collections.shuffle(unseenMemesShuffled);

        // Select only "num" memes
        return unseenMemesShuffled.subList(0, Math.min(unseenMemesShuffled.size(), num));
    }


    /**
     * Calculation: Get "Matches" ~ other users for this user
     * @param user
     * @return
     */
    @Transactional(readOnly = true)
    public List<User> getMatches(@NonNull User user) {
        return userRepository.findAllByUuidNot(user.getUuid());
    }

    /**
     * Helper method: Get Common Swipes between two users
     *
     * @param user
     * @param other
     * @return
     */
    @Transactional(readOnly = true)
    private Stream<Meme> commonSwipes(@NonNull User user, @NonNull User other) {
        return filterCommonSwipes(user, other, (userSwipe, otherSwipe) -> true);
    }

    /**
     * Helper Method: Get Agreements on memes between two users
     *
     * @param user
     * @param other
     * @return
     */
    @Transactional(readOnly = true)
    private Stream<Meme> agreements(@NonNull User user, @NonNull User other) {
        return filterCommonSwipes(user, other, (userSwipe, otherSwipe) -> userSwipe.getLike() == otherSwipe.getLike());
    }

    /**
     * Helper Method: Get Disagreements on memes between two users
     *
     * @param user
     * @param other
     * @return
     */
    @Transactional(readOnly = true)
    private Stream<Meme> disagreements(@NonNull User user, @NonNull User other) {
        return filterCommonSwipes(user, other, (userSwipe, otherSwipe) -> userSwipe.getLike() == otherSwipe.getLike());
    }


    /**
     * Helper Method
     *
     * @param user
     * @param other
     * @param filter
     * @return
     */
    @Transactional(readOnly = true)
    private Stream<Meme> filterCommonSwipes(@NonNull User user, @NonNull User other, @NonNull BiFunction<Swipe,
            Swipe, Boolean> filter) {
        Set<Swipe> userSwipes = user.getSwipes();
        Set<Swipe> otherSwipes = other.getSwipes();

        return userSwipes.stream().filter(userSwipe -> otherSwipes.stream().anyMatch(otherSwipe -> otherSwipe.getMeme
                () == userSwipe.getMeme() && filter.apply(userSwipe, otherSwipe))).map(Swipe::getMeme);
    }
}