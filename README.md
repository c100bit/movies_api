# README

/api/v1/countries - Fetch all countries
/api/v1/genres - Fetch all genres

/api/v1/movies - Rest-full movies

Fetching movies
/api/v1/movies?include=genres,country - Fetch all movies with relationships

Sorting movies
/api/v1/movies?order=(year|rate),asc=true (desc - default)

Filtering movies
/api/v1/movies?filter=(title|year|country_id|rate|genre_ids),val=(value) (genre_ids = 1,2,3)
