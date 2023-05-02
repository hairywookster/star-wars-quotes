# This workflow uses actions that are not certified by GitHub.
# They are provided by a third-party and are governed by
# separate terms of service, privacy policy, and support
# documentation.
# This workflow will download a prebuilt Ruby version, install dependencies and run tests with Rake
# For more information see: https://github.com/marketplace/actions/setup-ruby-jruby-and-truffleruby

name: Ruby

on:
  push:
    branches: [ $default-branch ]
  pull_request:
    branches: [ $default-branch ]

permissions:
  contents: read

jobs:
  test:

    runs-on: ubuntu-latest
    strategy:
      matrix:
        ruby-version: ['3.1', '3.0', '2.7']

    steps:
    - uses: actions/checkout@v3
    - name: Set up Ruby
      # Automatically get bug fixes and new Ruby versions for ruby/setup-ruby,
      # See https://github.com/ruby/setup-ruby#versioning
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: ${{ matrix.ruby-version }}
        bundler-cache: true # runs 'bundle install' and caches installed gems automatically
    - name: Run tests
      run: bundle exec rake
    - name: Publish to RubyGems
    run: |
      mkdir -p $HOME/.gem
      touch $HOME/.gem/credentials
      chmod 0600 $HOME/.gem/credentials
      printf -- "---\n:rubygems_api_key: ${GEM_HOST_API_KEY}\n" > $HOME/.gem/credentials
      gem build *.gemspec
      gem push *.gem
    env:
      GEM_HOST_API_KEY: "${{secrets.RUBYGEMS_AUTH_TOKEN}}"
