#! /usr/bin/env ruby
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

require 'sensu-plugin/check/cli'

class CheckNTP < Sensu::Plugin::Check::CLI
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

  def run
    begin
      output = `ntpq -c "rv 0 stratum,offset"`.split("\n").find { |line|  line.start_with?('stratum')  }
      stratum = output.split(',')[0].split('=')[1].strip.to_i
      offset = output.split(',')[1].split('=')[1].strip.to_f
    rescue
      unknown 'NTP command Failed'
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
