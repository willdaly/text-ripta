# Text RIPTA

Text RIPTA is a Rails app built for the HackRI civic hackathon. It lets a rider text a RIPTA stop ID and receive an SMS back with the next bus arrivals for that stop.

The app combines seeded RIPTA route and trip data with RIPTA's real-time vehicle positions API, then responds through Twilio.

## What It Does

- Accepts inbound SMS messages from Twilio.
- Treats the message body as a RIPTA stop ID.
- Looks up trips serving that stop.
- Fetches live vehicle positions from RIPTA.
- Replies with up to two upcoming bus status messages.

Example response:

```text
Broad St is 2 stops away, Downtown is 5 stops away
```

If the stop cannot be found, the app replies with a not-found message.

## Request Flow

1. Twilio sends an inbound webhook to `POST /messages/reply`.
2. `MessagesController` builds a `Message` from the incoming SMS body.
3. `Message` resolves the stop, gathers matching vehicles, and formats a reply.
4. `TwilioService` sends the SMS response back to the original sender.

## Stack

- Ruby on Rails 5.0.1
- PostgreSQL
- Twilio for SMS delivery
- HTTParty for RIPTA API requests

## Local Setup

### Prerequisites

- A legacy Ruby version compatible with Rails 5.0.1
- PostgreSQL
- Bundler

This project was built against an older Ruby and Bundler toolchain. The checked-in lockfile is for Bundler `1.13.6`, so a modern machine may need either:

- a Ruby version manager such as `rbenv` or `rvm` to install an older Ruby, and
- an older Bundler release to match the lockfile, or a fresh lockfile generated after dependency upgrades.

If you are reviving the project rather than preserving it historically, expect some setup friction from old gem versions such as Rails 5.0.1, Puma 3, and the original `pg` and `twilio-ruby` releases.

### Install

```bash
gem install bundler -v 1.13.6
bundle install
bin/rails db:create db:migrate db:seed
```

The seed task loads trip and route-stop data from the JSON files in `lib/data/`.

If `bundle install` fails on a current machine, the practical next step is to upgrade the dependency set and regenerate `Gemfile.lock` rather than keep forcing newer tooling to behave like a 2016 environment.

## Configuration

Set these environment variables before running the server:

```bash
export ACCOUNT_SID=your_twilio_account_sid
export AUTH_TOKEN=your_twilio_auth_token
export TWILIO_NUMBER=your_twilio_phone_number
```

## Running The App

Start the Rails server:

```bash
bin/rails server
```

Configure your Twilio phone number's messaging webhook to point to:

```text
POST /messages/reply
```

When a rider texts a stop ID to the Twilio number, the app will reply with the next arriving RIPTA buses it can infer from the real-time feed.

## Tests

Run the test suite with:

```bash
bin/rails test
```

## Notes

- RIPTA real-time data is fetched from the vehicle positions endpoint at request time.
- Seed data is based on the JSON files checked into `lib/data/`.
- Response formatting is intentionally simple because the app was built as a hackathon prototype.
- The app currently points at `http://realtime.ripta.com:81/api/vehiclepositions?format=json`; if you try to run this today, verify that the endpoint still exists and that the response shape has not changed.
