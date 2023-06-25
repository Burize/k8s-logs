# Authentication microservice
This is microservice written in Python using [FastAPI](https://fastapi.tiangolo.com/) as a framework. The purpose of this service is to provide user authentication by username and password. 

Service provides two endpoints:
- POST `/api/authenticate` to authenticate a user by username and passwrod. If an attempt is successful, it returns user's id and email;
- POST `/api/user` to create a new user.

There are two env variables `SERVICE_EXHANGE_HEADER_NAME` and  `SERVICE_EXHANGE_KEY`. 
You should put a value from `SERVICE_EXHANGE_KEY` to a http header with name `SERVICE_EXHANGE_HEADER_NAME` on each request that you make to pass authentication.

### Run service
Run `docker compose up` to build and run server and database containers.

After containers are started, you need to run:
```
docker exec -it auth_service_backend bash -c "alembic upgrade heads"
```

This command applies migrations that create initial tables in the database.

After that you can use the server. It's available on `127.0.0.1:8083`

Also, you can run this command to create a new user without http request:
```
docker exec -it auth_service_backend bash -c "python add_user.py --username user_1 --password 1234 --email user_1@email.com" 
```