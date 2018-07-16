# ActiveCampaign

[![CircleCI](https://circleci.com/gh/rtcreativegroup/active_campaign_rb/tree/master.svg?style=shield)](https://circleci.com/gh/rtcreativegroup/active_campaign_rb/tree/master)
[![Test Coverage](https://api.codeclimate.com/v1/badges/69ccab5404f357456335/test_coverage)](https://codeclimate.com/github/rtcreativegroup/active_campaign_rb/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/69ccab5404f357456335/maintainability)](https://codeclimate.com/github/rtcreativegroup/active_campaign_rb/maintainability)

A Ruby wrapper for the ActiveCampaign API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_campaign_rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_campaign_rb

## FYI

We've done our best to match this gem's API to ActiveCampaign's API & API docs. However, the ActiveCampaign APIs and/or API docs seem to have some bugs and gotchas to watch out for. A list of those found so far can be found in [docs/API_BUGS_AND_GOTCHAS.md](docs/API_BUGS_AND_GOTCHAS.md).

If there's a question about why something in this gem's API doesn't match ActiveCampaign's API docs, you should look there first.

## Usage

### Setting API URL and KEY

Set your API base url and key in one of the following ways:

1. Environment Variables
    ```Shell
    ENV['ACTIVE_CAMPAIGN_URL'] = 'https://ACCOUNT_NAME.api-us1.com'
    ENV['ACTIVE_CAMPAIGN_KEY'] = 'YOUR-API-KEY-GOES-HERE'
    ```
2. Rails Initializer
    ```Ruby
    ActiveCampaign::Settings.configure do |config|
      config.base_url = 'https://ACCOUNT_NAME.api-us1.com'
      config.api_key = 'YOUR-API-KEY-GOES-HERE'
    end
    ```

Your API URL & Key can be found under **Settings > Developer** in the ActiveCampaign admin panel.

### Setting API Url and Key

### Making API Requests

1. Instantiate a client
    - v2
        ```Ruby
        c = ActiveCampaign::V2::Client.new
        ```
    - v3
        ```Ruby
        c = ActiveCampaign::V3::Client.new
        ```
    NOTE: You can also pass your `base_url` & `api_key` to `Client.new`, i.e.
    ```Ruby
    ActiveCampaign::V3::Client.new(
      base_url: 'https://ACCOUNT_NAME.api-us1.com',
      api_key: 'YOUR-API-KEY-GOES-HERE'
    )
    ```
2. Call methods on the client, passing a hash of params. Required params for the API are required for this gem
    ```Ruby
    response = c.deal_create(
      title: 'New Deal',
      contact: '1',
      value: 30000,
      currency: 'usd',
      group: '1',
      stage: '1',
      owner: '1',
      percent: 25,
      status: 0
    )
    ```
3. Returns JSON
    ```Json
    {
      "contacts": [
        {
         "cdate": "2018-07-09T10:46:02-05:00",
         "email": "test@test.com",
         "phone": "",
         "firstName": "",
         "lastName": "",
         "orgid": "0",
         "segmentio_id": "",
         "bounced_hard": "0",
         "bounced_soft": "0",
         "bounced_date": null,
         "ip": "0",
         "ua": null,
         "hash": "55555555555555555555555555555555",
         "socialdata_lastcheck": null,
         "email_local": "",
         "email_domain": "",
         "sentcnt": "0",
         "rating_tstamp": null,
         "gravatar": "0",
         "deleted": "0",
         "anonymized": "0",
         "adate": null,
         "udate": null,
         "edate": null,
         "deleted_at": null,
         "links": {
          "bounceLogs": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/bounceLogs",
          "contactAutomations": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/contactAutomations",
          "contactData": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/contactData",
          "contactGoals": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/contactGoals",
          "contactLists": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/contactLists",
          "contactLogs": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/contactLogs",
          "contactTags": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/contactTags",
          "contactDeals": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/contactDeals",
          "deals": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/deals",
          "fieldValues": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/fieldValues",
          "geoIps": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/geoIps",
          "notes": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/notes",
          "organization": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/organization",
          "plusAppend": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/plusAppend",
          "trackingLogs": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/trackingLogs",
          "scoreValues": "https://ACCOUNT_NAME.api-us1.com/api/3/contacts/14/scoreValues"
        },
        "id": "1",
        "organization": null
      }
    ],
      "dealStages": [
       {
         "group": "1",
         "title": "To Contact",
         "color": "18D499",
         "order": "1",
         "width": "280",
         "dealOrder": "next-action DESC",
         "cardRegion1": "title",
         "cardRegion2": "next-action",
         "cardRegion3": "show-avatar",
         "cardRegion4": "contact-fullname-orgname",
         "cardRegion5": "value",
         "cdate": null,
         "udate": null,
         "links": {
           "group": "https://ACCOUNT_NAME.api-us1.com/api/3/dealStages/1/group"
         },
         "id": "1"
       }
     ],
      "deal": {
        "percent": 25,
        "status": 0,
        "title": "New Deal",
        "value": 30000,
        "currency": "usd",
        "contact": 1,
        "group": "1",
        "stage": "1",
        "owner": "1",
        "cdate": "2018-07-13T13:06:30-05:00",
        "mdate": "2018-07-13T13:06:30-05:00",
        "description": "",
        "hash": "55555555",
        "organization": null,
        "winProbability": null,
        "winProbabilityMdate": null,
        "links": {
          "activities": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/activities",
          "contact": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/contact",
          "contactDeals": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/contactDeals",
          "group": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/group",
          "nextTask": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/nextTask",
          "notes": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/notes",
          "organization": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/organization",
          "owner": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/owner",
          "scoreValues": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/scoreValues",
          "stage": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/stage",
          "tasks": "https://ACCOUNT_NAME.api-us1.com/api/3/deals/4/tasks"
        },
        "id": "1",
        "isDisabled": false
      }
    }
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rtcreativegroup/active_campaign. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
