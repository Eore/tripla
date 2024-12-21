# Good Night App

## Prerequisite

- Container runtime (`podman` or `docker`)
- Code editor

This project using SQLite database, so you dont need to setup any database, it will be setup by Rails

## How to start?

### Development

Let assume that you use `podman` (you can change the `podman` command to `docker` if you using Docker). First, to start this project in development mode, you need to build the image first:

```shell
podman build -t tripla-api -f Dockerfile.dev .
```

After build the image, you can run the image using this command:

```shell
podman run -d --rm --name tripla-api -v ./:/app -p 3000:3000 tripla-api
```

And open `localhost:3000` to test if server running or not. Then you can just start the development without restarting the service.

> [!IMPORTANT]  
> Make sure that development container is running to procced to the next step, Migration and Adding User

### Migration

For first time run, you need to do the migration first. To do this, you need to execute:

```shell
podman exec -it tripla-api /app/bin/rails db:migrate
```

### Adding user

To add the user, you can use Rails Console. First you need to `exec` to running container using:

```shell
podman exec -it tripla-api /app/bin/rails console
```

Inside that, you can execute:

```rails
User.create name: "foobar"
```

It will create new user with name `foobar`

## API List

### Clock in and out

`POST /clock/:user_id`

It will clock in if no latest clock in exist and clock out when you already clocked in.
You can't clock in multiple time, you must clock out first then you can clock in again.

Example response:

`200 OK`

```json
[
  {
    "id":1,
    "clock_in":"2024-12-20T15:27:52.003Z","clock_out":"2024-12-20T15:28:29.127Z","duration":37.123841,
    "user_id":1
  },
  {
    "id":2,
    "clock_in":"2024-12-20T15:29:05.992Z","clock_out":"2024-12-20T15:29:07.835Z","duration":1.843107,
    "user_id":1
  },
  {
    "id":7,
    "clock_in":"2024-12-21T14:48:24.400Z","clock_out":null,
    "duration":null,
    "user_id":1
  }
]
```

### Follow user

`POST /follows`

To follow registered user. Followed user will appear on sleep log list.

Payload:

- `user_id`: Id of the user that want do the follow action
- `follow_id`: Id of the user that want to follow

Example request:

```json
{
  "user_id": 1,
  "follow_id": 2
}
```

Example response:

`200 OK`

```json
{
  "id": 1,
  "user_id": 1,
  "follow_id": 2,
  "created_at": "2024-12-21T14:53:28.960Z",
  "updated_at": "2024-12-21T14:53:28.960Z"
}
```

### Show sleep logs

`GET /sleep_logs/:user_id`

Show all the user and followed user of the sleep logs, order by duration from longest to shortest.

Example response:

200 OK

```json
[
  {
    "id": 1,
    "clock_in": "2024-12-20T15:27:52.003Z",
    "clock_out": "2024-12-20T15:28:29.127Z",
    "duration": 37.123841,
    "user_id": 1
  },
  {
    "id": 2,
    "clock_in": "2024-12-20T15:29:05.992Z",
    "clock_out": "2024-12-20T15:29:07.835Z",
    "duration": 1.843107,
    "user_id": 1
  },
  {
    "id": 3,
    "clock_in": "2024-12-20T16:10:56.272Z",
    "clock_out": "2024-12-20T16:10:57.668Z",
    "duration": 1.396234,
    "user_id": 2
  },
  {
    "id": 4,
    "clock_in": "2024-12-20T16:10:58.857Z",
    "clock_out": "2024-12-20T16:11:00.032Z",
    "duration": 1.175827,
    "user_id": 2
  }
]
```

### Unfollow user

`DELETE /follows/:follow_id`

Unfollow user by follow id.

Example response:

`204 No Content`

### Show followed users

`GET /follows/:user_id`

Show all followed user by provided user id.

Example response:

200 OK

```json
[
  {
    "id": 1,
    "user_id": 1,
    "follow_id": 2,
    "created_at": "2024-12-20T15:29:46.662Z",
    "updated_at": "2024-12-20T15:29:46.662Z"
  }
]
```
