# NhkEasyToInstapaper

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Run the app in development

Install dependencies with `mix deps.get`
Create a file in the root directory called `.env` that contains the following environment variables:

  * INSTAPAPER_USERNAME
  * INSTAPAPER_PASSWORD

Then run

```
gem install foreman
foreman start -f Procfile.dev
```

You will then be able to see simplified NHK EASY articles at `http://localhost:4000/{articleId}` where `articleId` is for example `k10010844631000`. If you visit any NHK EASY article page you will be able to see this id in the url.

## Deployment

To deploy on Heroku click on the Deploy to Heroku button at the top of this readme. The only required variables are:

  * INSTAPAPER_USERNAME
  * INSTAPAPER_PASSWORD
  
There is an optional variable called `TIMEZONE` which by default is set to `Europe/London`. Valid options are :utc or a timezone name such as "America/Chicago". A full list of timezone names can be downloaded from https://www.iana.org/time-zones, or at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones.

The app will be deployed on a free dyno but it will require a hobby dyno to be up and running 24/7 which is important to let the quantum elixir library to work like cron and schedule the job that puts the article on instapaper.
