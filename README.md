## Sensu-Plugins-ntp

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-ntp.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-ntp)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-ntp.svg)](http://badge.fury.io/rb/sensu-plugins-ntp)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-ntp.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-ntp)
[ ![Codeship Status for sensu-plugins/sensu-plugins-ntp](https://codeship.com/projects/931f8480-dc04-0132-649b-025863fcc952/status?branch=master)](https://codeship.com/projects/79858)

## Functionality

## Files
 * bin/check-ntp
 * bin/metrics-ntpdate
 * bin/metrics-ntpstats

## Usage

## Installation

Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install sensu-plugins-ntp -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

#### Rubygems

`gem install sensu-plugins-ntp`

#### Bundler

Add *sensu-plugins-disk-checks* to your Gemfile and run `bundle install` or `bundle update`

#### Chef

Using the Sensu **sensu_gem** LWRP
```
sensu_gem 'sensu-plugins-ntp' do
  options('--prerelease')
  version '0.0.1'
end
```

Using the Chef **gem_package** resource
```
gem_package 'sensu-plugins-ntp' do
  options('--prerelease')
  version '0.0.1'
end
```

## Notes
