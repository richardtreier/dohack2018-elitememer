package de.dohack2018.elitememer.elitememerbackend.web;

import graphql.execution.ExecutionStrategy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class GraphQLConfig {
    /**
     * Copied from Stackoverflow
     *
     * @return
     */
    @Bean
    public Map<String, ExecutionStrategy> executionStrategies() {
        Map<String, ExecutionStrategy> executionStrategyMap = new HashMap<>();
        executionStrategyMap.put("queryExecutionStrategy", new AsyncTransactionalExecutionStrategy());
        return executionStrategyMap;
    }
}
