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

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_campaign. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveCampaign project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_campaign/blob/master/CODE_OF_CONDUCT.md).
