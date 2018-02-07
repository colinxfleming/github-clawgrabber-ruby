# Github Clawgrabber

Is your heart's deepest wish to mash variables into something that doesn't
have variables, and smash the

Works great with:

* Shared reporting SQL -- define variables and constants, and keep em version
  controlled! No more mystery UDFs!
* Mass generating files based on a template!
* Literally anything else where you find yourself wishing 'I wish I had a
  ruby function I could write instead of this!'

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github_clawgrabber'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github_clawgrabber

## Usage

This is built around a core `GithubClawgrabber` module that takes an
unfortunate amount of arguments. Chances are, the one you want is `grab`.

```
GithubClawgrabber.grab(auth_token, repo, filepath, branch = 'master', *helper_modules)
```

Let's break these arguments out:

* `auth_token`: A github authentication token. Directions to get one are
  [here](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).
* `repo`: The github repo path. ex: `colinxfleming/github_clawgrabber_ruby`.
* `filepath`: The path to the file within that repo. ex:
  `samples/each_loop.txt.erb`.
* `branch`: A chance to set your branch to not-master if you're working
  on something.
* `helper_modules`: A splat of modules you can jam into your templates. ex:
  `[ActiveSupport::Inflector, DateHelper]`. (Contrived example!)

There are a few subclasses that do the heavy lifting with public methods
exposed, described below.

### Fetcher

```
GithubClawgrabber::Fetcher.fetch
GithubClawgrabber::Templater.template
GithubClawgrabber::ContextShell
```

### Templater

This utility class does the ERB templating, using the `ContextShell`.

```
GithubClawgrabber::Templater.template(item, context)
```

### ContextShell

This utility class lets you jam in as much in the way of helper modules as your
heart desires.

```
context = ContextShell.new(helper_modules)
context.access_binding
```

#### Advice on writing helpers

* I've had best results when keeping them functional, in the sense of not being
  concerned with the state of what's in `ContextShell`.
* That said: ERB puts ruby at your fingertips, so go nuts.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/colinxfleming/github_clawgrabber.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GithubClawgrabber project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/colinxfleming/github_clawgrabber/blob/master/CODE_OF_CONDUCT.md).
