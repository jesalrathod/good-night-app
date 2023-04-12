# Good Night Sample App

## Features
* Clock In operation, and return all clocked-in times, ordered by created time.
* Users can follow and unfollow other users.
* See the sleep records over the past week for their friends, ordered by the length of their
  sleep.

## How To Run Locally
* Clone this repo: ```git clone https://github.com/jesalrathod/good-night-app.git```
* Ensure PostgreSQL is already running on your local machine
* Adjust config/database.yml according to your local DB setup
* Run `bundle install`
* Run `rails db:create`
* Run `rails db:migrate`
* Run `bundle exec rspec` to make sure the tests are passed
* Run `rails s`

## Available API end-points
### Follow a User
* API end-point: `POST /api/v1/follows`
* Request body: `{ "follower_name": "Bob Marle", "followee_name": "Charlie Chaplin" }`
* Response body: `{"id": 1, "name": "Jesal Rathod", "created_at": "2023-04-10T12:26:48.624Z", "updated_at": "2023-04-10T12:26:48.624Z"}, {"id": 38, "name": "Charlie Chaplin", "created_at": "2023-04-12T14:36:38.716Z", "updated_at": "2023-04-12T14:36:38.716Z"}`
* Response code: 201

### Unfollow a User
* API end-point: `DELETE /api/v1/follows/:followee_id`
* Request body: `{ "follower_name": "Bob Marle", "followee_name": "Charlie Chaplin" }`
* Response body: `{}`
* Response code: 204

### User Clock-In & Clock-Out
* API end-point: `POST /api/v1/clocks`
* Request body: `{ "name": "Jesal Rathod" }`
* Response body: `{"id": 1, "clock_in_time": "2023-04-12T14:46:05.966Z", "clock_out_time": "2023-04-12T16:46:05.966Z", "user_id": 1, "created_at": "2023-04-12T14:46:05.976Z", "updated_at": "2023-04-12T14:46:05.976Z"}`
* Response code: 201

### Get Current User All Clock-In's & Clock-Out's
* API end-point: `GET /api/v1/clocks`
* Request body: `{ "name": "Jesal Rathod" }`
* Response body: `{"id": 2, "clock_in_time": "2023-04-12T14:49:25.290Z", "clock_out_time": "2023-04-12T16:49:25.290Z", "user_id": 1, "created_at": "2023-04-12T14:49:25.290Z", "updated_at": "2023-04-12T14:49:25.290Z"}, {"id": 1, "clock_in_time": "2023-04-12T14:49:24.564Z", "clock_out_time": "2023-04-12T16:49:24.564Z", "user_id": 1, "created_at": "2023-04-12T14:49:24.564Z", "updated_at": "2023-04-12T14:49:24.564Z"}`
* Response code: 201

### Get Current User All Friends Sleep Records
* API end-point: `GET /api/v1/user_sleep_records`
* Request body: `{ "name": "Jesal Rathod" }`
* Response body: `{"id": 2, "clock_in_time": "2023-04-12T14:49:25.290Z", "clock_out_time": "2023-04-12T16:49:25.290Z", "user_id": 1, "created_at": "2023-04-12T14:49:25.290Z", "updated_at": "2023-04-12T14:49:25.290Z"}, {"id": 1, "clock_in_time": "2023-04-12T14:49:24.564Z", "clock_out_time": "2023-04-12T15:49:24.564Z", "user_id": 1, "created_at": "2023-04-12T14:49:24.564Z", "updated_at": "2023-04-12T14:49:24.564Z"}`
* Response code: 201
* Note: If Current User has Friends then only sleep records list will output based on ordered by length else it will be {}