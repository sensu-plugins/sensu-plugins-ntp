#! /usr/bin/env ruby
# frozen_string_literal: true

#
#   check-ntp
#
# DESCRIPTION:
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#
# NOTES:
#  warning and critical values are offsets in milliseconds.
#
# LICENSE:
#   Copyright 2012 Sonian, Inc <chefs@sonian.net>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#
# Stratum Levels
# 1:      Primary reference (e.g., calibrated atomic clock, radio clock, etc...)
# 2-15:   Secondary reference (via NTP, calculated as the stratum of your system peer plus one)
# 16:     Unsynchronized
# 17-255: Reserved
#
# Source Field Status Codes
# http://doc.ntp.org/current-stable/decode.html

require 'sensu-plugin/check/cli'

class CheckNTP < Sensu::Plugin::Check::CLI
  option :host,
         short: '-h HOST',
         default: '127.0.0.1'

  option :warn,
         short: '-w WARN',
         proc: proc(&:to_f),
         default: 10

  option :crit,
         short: '-c CRIT',
         proc: proc(&:to_f),
         default: 100

  option :stratum,
         short: '-s STRATUM',
         description: 'check that stratum meets or exceeds desired value',
         proc: proc(&:to_i),
         default: 15

  option :unsynced_status,
         short: '-u CODE',
         description: 'If ntp_status is unsynced (that is, not yet connected to or disconnected from ntp), what should the response be.',
         proc: proc(&:downcase),
         default: 'unknown'

  def run
    begin
      output = `ntpq -c raw -c 'rv 0' '#{config[:host]}'`
      stratum = /stratum=(-?\d+)/.match(output)[1].to_i
      offset = /offset=(-?\d+(\.\d+)?)/.match(output)[1].to_f
      source_field_status = config[:unsynced_status] == 'ok' ? 6 : /status=((0x)?[0-9a-f]{2})/.match(output)[1].hex & 0x3f
    rescue StandardError
      unknown 'NTP command Failed'
    end

    if source_field_status.zero?
      case config[:unsynced_status]
      when 'warn'
        warning 'NTP state unsynced'
      when 'crit'
        critical 'NTP state unsynced'
      when 'unknown'
        unknown 'NTP state unsynced'
      end
    end

    if stratum > 15
      critical 'NTP not synced'
    elsif stratum > config[:stratum]
      critical "NTP stratum (#{stratum}) above limit (#{config[:stratum]})"
    end

    message = "NTP offset by #{offset.abs}ms"
    critical message if offset >= config[:crit] || offset <= -config[:crit]
    warning message if offset >= config[:warn] || offset <= -config[:warn]
    ok message
  end
end
