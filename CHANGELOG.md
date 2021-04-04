# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

### Added
- Command line option for host
- Updated asset build targets to support centos6
- Removed centos from bonsai asset definition

### Changed
- Updated rubocop dependency to '~> 0.79.0'
- Remediated issues identified by updating rubocop
- Updated rake dependency to '~> 13.0'

## [2.0.0] - 2019-04-19
### Breaking Changes
- Update minimum required ruby version to 2.3. Drop unsupported ruby versions.
- Bump `sensu-plugin` dependency from `~> 1.2` to `~> 4.0` you can read the changelog entries for [4.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#400---2018-02-17), [3.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#300---2018-12-04), and [2.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#v200---2017-03-29)

### Added
- Travis build automation to generate Sensu Asset tarballs that can be used n conjunction with Sensu provided ruby runtime assets and the Bonsai Asset Index
- Require latest sensu-plugin for [Sensu Go support](https://github.com/sensu-plugins/sensu-plugin#sensu-go-enablement)


## [1.0.2] - 2018-01-03
## Fixed
- check-ntp.rb: fix timeout issue bu using loopback (@mdzidic)

### Added
- Ruby 2.4.1 testing

### Changed
- update changelog guidelines location (@majormoses)

## [1.0.1] - 2016-12-30
### Fixed
- Fix interpretation of the leap field in check-ntp.rb (@corro)

## [1.0.0] - 2016-07-13
### Added
- Added check for unsynced NTP state with configurable severity, returns unknown by default.

### Changed
- Loosen dependency on sensu-plugin from = 1.2.0 to ~> 1.2
- Updated Rubocop to ~> 0.40, applied auto-correct.

### Removed
- Remove Ruby 1.9.3 support; add Ruby 2.3.0 support to test matrix

## [0.0.4] - 2015-10-24
### Fixed
- Fixed warning and critical args to use float instead of int.  Added arg to have a configurable stratum limit.

## [0.0.3] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

### Fixed
- Modified check-ntp.rb to ignore additional initial line of ntpq output on some systems (e.g. Centos6)

## [0.0.2] - 2015-06-03
### Fixed
- added binstubs

### Changed
- removed cruft from /lib

## 0.0.1 - 2015-05-20
### Added
- initial release

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/2.0.0...HEAD
[2.0.0]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/1.0.2...2.0.0
[1.0.2]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.4...1.0.0
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-ntp/compare/0.0.1...0.0.2
