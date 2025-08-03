# SQL_NETFLIX_PROJECT
# 📊 Netflix Movies and TV Shows Data Analysis Using SQL

## 📁 Overview
This project performs a comprehensive analysis of Netflix's content catalog using SQL. The objective is to uncover actionable insights and answer key business questions through structured queries. The analysis focuses on content types, ratings, release trends, and more to support data-driven decision-making.

---

## 🎯 Objectives

The primary goals of this project include:

- Analyze the distribution of content types (Movies vs TV Shows).
- Identify the most common ratings for movies and TV shows.
- Explore content trends based on release years, countries, and durations.
- Perform keyword-based categorization and filtering of content.
- Derive insights to support business strategies in content planning and audience targeting.

---

## 🗃️ Dataset

- **Source**: [Kaggle - Netflix Movies and TV Shows Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)
- **Format**: CSV
## schema
```sql

drop table if exists netflix
CREATE TABLE netflix
(
    show_id      VARCHAR(7),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

select * from netflix;

```
