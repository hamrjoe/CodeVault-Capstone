package com.techelevator.model;

import java.util.List;

public class Example {

    private String title;
    private String description;
    private List<String> tags;
    private long exampleId;
    private String languageName;
    private long languageId;
    private String codeExample;
    private boolean privateExample;
    private String attribution;
    private long userId;
    private boolean defaultExample;
    private boolean favoriteExample;

    public boolean isFavoriteExample() {
        return favoriteExample;
    }

    public void setFavoriteExample(boolean favoriteExample) {
        this.favoriteExample = favoriteExample;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getTags() {
        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    public long getExampleId() {
        return exampleId;
    }

    public void setExampleId(long exampleId) {
        this.exampleId = exampleId;
    }

    public String getLanguageName() {
        return languageName;
    }

    public void setLanguageName(String languageName) {
        this.languageName = languageName;
    }

    public long getLanguageId() {
        return languageId;
    }

    public void setLanguageId(long languageId) {
        this.languageId = languageId;
    }

    public String getCodeExample() {
        return codeExample;
    }

    public void setCodeExample(String codeExample) {
        this.codeExample = codeExample;
    }

    public String getAttribution() {
        return attribution;
    }

    public void setAttribution(String attribution) {
        this.attribution = attribution;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public boolean isPrivateExample() {
        return privateExample;
    }

    public void setPrivateExample(boolean privateExample) {
        this.privateExample = privateExample;
    }

    public boolean isDefaultExample() {
        return defaultExample;
    }

    public void setDefaultExample(boolean defaultExample) {
        this.defaultExample = defaultExample;
    }
}
