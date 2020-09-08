[![Sensu Bonsai Asset](https://img.shields.io/badge/Bonsai-Download%20Me-brightgreen.svg?colorB=89C967&logo=sensu)](https://bonsai.sensu.io/assets/sensu-plugins/sensu-plugins-ntp)
[ ![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-ntp.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-ntp)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-ntp.svg)](http://badge.fury.io/rb/sensu-plugins-ntp)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ntp)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-ntp.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-ntp)


## Sensu Plugins NTP Plugin

- [Overview](#overview)
- [Files](#files)
- [Usage examples](#usage-examples)
- [Configuration](#configuration)
  - [Sensu Go](#sensu-go)
    - [Asset registration](#asset-registration)
    - [Asset definition](#asset-definition)
    - [Check definition](#check-definition)
  - [Sensu Core](#sensu-core)
    - [Check definition](#check-definition)
- [Installation from source](#installation-from-source)
- [Additional notes](#additional-notes)
- [Contributing](#contributing)

### Overview

This plugin provides native network time protocol (NTP) instrumentation for monitoring and metrics collection, including server drift and metrics via `ntpdate` and `ntpstats`.

### Files
 * check-ntp.rb
 * metrics-ntpdate.rb
 * metrics-ntpstats.rb
 
**check-ntp** 
Checks the synchronization state of local or remote NTP server.

* Parameters:
  - `host`: Host name/address (default: `127.0.0.1`)
  - `warn`: Maximum offset in ms for warning state (default: `10`)
  - `crit`: Maximum offset in ms for critical state (default: `100`)
  - `stratum`: Maximum stratum value (default: `15`)
  - `unsynced_status`: Default status when unsynced (default: `UNKNOWN`)

**metrics-ntpdate**
Gets metrics from `ntpdate`.

* Parameters:
  - `server`: Comma-separated list of NTP server(s) to measure (default: `localhost`)
  - `scheme`: Prefix for metrics (default: `hostname`)

* Values:
  - `offset`: Time difference between server and source (unit: ms)
  - `delay`: Roundtrip time from server to source (unit: ms)

**metrics-ntpstats**
Gets metrics from `ntpstats`.

* Parameters:
  - `host`: Target host (default: `localhost`)
  - `scheme`: Prefix for metrics (default: `hostname`)

* Values (descriptions from https://www.eecis.udel.edu/~mills/ntp/html/ntpq.html):
  - `clk_jitter`: Clock jitter
  - `clk_wander`: Clock frequency wander
  - `frequency`: Frequency offset relative to hardware clock
  - `mintc`: Minimum time constant
  - `offset`: Combined offset of server relative to this host
  - `stratum`: Stratum
  - `sys_jitter`: Combined system jitter
  - `tc`: Time constant and poll exponent

## Usage examples

### Help

**check-ntp.rb**
```
Usage: check-ntp.rb (options)
    -h HOST
    -c CRIT
    -s STRATUM                       check that stratum meets or exceeds desired value
    -u CODE                          If ntp_status is unsynced (that is, not yet connected to or disconnected from ntp), what should the response be.
    -w WARN
```

**metrics-ntpdate.rb**
```
Usage: metrics-ntpdate.rb (options)
    -s, --scheme SCHEME              Metric naming scheme, text to prepend to metric
        --server SERVER1[,SERVER2,..]
                                     NTP server(s)
```

**metrics-ntpstats.rb**
```
Usage: metrics-ntpstats.rb (options)
    -h, --host HOST                  Target host
    -s, --scheme SCHEME              Metric naming scheme, text to prepend to metric
```

## Configuration
### Sensu Go
#### Asset registration

Assets are the best way to make use of this plugin. If you're not using an asset, please consider doing so! If you're using sensuctl 5.13 or later, you can use the following command to add the asset: 

`sensuctl asset add sensu-plugins/sensu-plugins-ntp`

If you're using an earlier version of sensuctl, you can download the asset definition from [this project's Bonsai asset index page](https://bonsai.sensu.io/assets/sensu-plugins/sensu-plugins-ntp).

#### Asset definition

```yaml
---
type: Asset
api_version: core/v2
metadata:
  name: sensu-plugins-ntp
spec:
  url: https://assets.bonsai.sensu.io/a24eea423200374c5b7f96082dd7e315fc1ea814/sensu-plugins-ntp_2.0.0_centos_linux_amd64.tar.gz
  sha512: 3ee7b68d91798775f70ee9cd037f98a82386ae9beccd069a4db262d6b69ef49db65a1415cc40c2a6c8726447f0cf4978a332968edf132cd79805ce4f68889a5a
```

#### Check definition

```yaml
---
type: CheckConfig
spec:
  command: "check-ntp.rb"
  handlers: []
  high_flap_threshold: 0
  interval: 10
  low_flap_threshold: 0
  publish: true
  runtime_assets:
  - sensu-plugins/sensu-plugins-ntp
  - sensu/sensu-ruby-runtime
  subscriptions:
  - linux
```

### Sensu Core

#### Check definition
```json
{
  "checks": {
    "check-ntp": {
      "command": "check-ntp.rb",
      "subscribers": ["linux"],
      "interval": 10,
      "refresh": 10,
      "handlers": ["influxdb"]
    }
  }
}
```

## Installation from source

### Sensu Go

See the instructions above for [asset registration](#asset-registration).

### Sensu Core

Install and setup plugins on [Sensu Core](https://docs.sensu.io/sensu-core/latest/installation/installing-plugins/).

## Additional notes

### Sensu Go Ruby Runtime Assets

The Sensu assets packaged from this repository are built against the Sensu Ruby runtime environment. When using these assets as part of a Sensu Go resource (check, mutator, or handler), make sure to include the corresponding [Sensu Ruby Runtime Asset](https://bonsai.sensu.io/assets/sensu/sensu-ruby-runtime) in the list of assets needed by the resource.

## Contributing

See [CONTRIBUTING.md](https://github.com/sensu-plugins/sensu-plugins-ntp/blob/master/CONTRIBUTING.md) for information about contributing to this plugin.
