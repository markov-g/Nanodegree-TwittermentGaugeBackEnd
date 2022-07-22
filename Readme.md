### Test
To test with PostgreSQL, run the Postgres server in a Docker container. Open Terminal and enter:
```
docker run --name postgres -e POSTGRES_DB=vapor_database \
  -e POSTGRES_USER=vapor_username \
  -e POSTGRES_PASSWORD=vapor_password \
  -p 5432:5432 -d postgres
```

This:
- Runs a new container named postgres.
- Then specifies the database name, username and password through environment variables.
- Lets apps connect to the Postgres server on its default port: 5432.
- Then runs the server in the background as a daemon.
- Uses the Docker image named postgres for this container. If the image isn’t present on your machine, Docker automatically downloads it.
                                            
To make a post request, start the application and:
```
curl -X POST -H "Content-Type: application/json" -d '{"text": "some text", "label": "Neg"}' http://localhost:8080/api/tweets
```

To delete a tweet:
```
curl -X "DELETE" 'http://localhost:8080/api/tweets/<<id>>'
```
where id is something like: `9A46B342-FC43-48C3-98AE-9B8656E659AE`
curl -X "DELETE" 'http://localhost:8080/api/tweets/A46B342-FC43-48C3-98AE-9B8656E659AE
