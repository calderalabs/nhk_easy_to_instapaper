# NhkEasyToInstapaper

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Add one NHK EASY article to Instapaper every day.

## Run the app in development

Install dependencies with `mix deps.get` then install and run Redis:

```
brew install redis
redis-server
```

Create a file in the root directory called `.env` like this:

```
INSTAPAPER_USERNAME=yourusername
INSTAPAPER_PASSWORD=yourpassword
HOST=http://localhost:4000
```

Then run:

```
gem install foreman
foreman start -f Procfile.dev
```

You will then be able to see simplified NHK EASY articles at `http://localhost:4000/{articleId}` where `articleId` is for example `k10010844631000`. If you visit any NHK EASY article page you will be able to see this id in the url.

## Deployment

To deploy on Heroku click on the Deploy to Heroku button at the top of this readme. The only required variables are:

  * INSTAPAPER_USERNAME
  * INSTAPAPER_PASSWORD
  * HOST

`HOST` is `http://yourappname.herokuapp.com`

There is an optional variable called `TIMEZONE` which by default is set to `Europe/London`. Valid options are :utc or a timezone name such as "America/Chicago". A full list of timezone names can be downloaded from https://www.iana.org/time-zones, or at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones.

The app will be deployed on a free dyno but it will require a hobby dyno to be up and running 24/7 which is important to let the quantum elixir library work like cron and schedule the job that puts the article on instapaper.

## Testing

If you wish to test that articles can be pushed to Instapaper then run:

```
heroku run "iex -S mix" -a yourappname
NhkEasyToInstapaper.Pusher.push_to_instapaper
```

You should then see an article appear on your Instapaper app.
