function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Display current UTC time and US timezones with their offsets
function utc() {
	echo "Current time in US timezones:"
	echo "============================="
	echo "UTC:                    $(TZ=UTC date '+%Y-%m-%d %H:%M:%S %Z (%z)')"
	echo "Eastern:                $(TZ=America/New_York date '+%Y-%m-%d %H:%M:%S %Z (%z)')"
	echo "Central:                $(TZ=America/Chicago date '+%Y-%m-%d %H:%M:%S %Z (%z)')"
	echo "Mountain:               $(TZ=America/Denver date '+%Y-%m-%d %H:%M:%S %Z (%z)')"
	echo "Mountain (No DST):      $(TZ=America/Phoenix date '+%Y-%m-%d %H:%M:%S %Z (%z)')"
	echo "Pacific:                $(TZ=America/Los_Angeles date '+%Y-%m-%d %H:%M:%S %Z (%z)')"
}

# Convert UTC timestamp to all major timezones
function futc() {
	if [ $# -eq 0 ]; then
		echo "Usage: futc 'YYYY-MM-DD HH:MM:SS'"
		echo "Example: futc '2025-08-15 16:21:00'"
		return 1
	fi
	
	local utc_timestamp="$1"
	echo "Converting UTC time: $utc_timestamp"
	echo "====================================="
	echo "UTC:                    $(TZ=UTC gdate -d "$utc_timestamp" '+%Y-%m-%d %H:%M:%S %Z (%z)' 2>/dev/null || echo "Invalid timestamp format")"
	echo "Eastern:                $(TZ=America/New_York gdate -d "$utc_timestamp UTC" '+%Y-%m-%d %H:%M:%S %Z (%z)' 2>/dev/null || echo "Invalid timestamp format")"
	echo "Central:                $(TZ=America/Chicago gdate -d "$utc_timestamp UTC" '+%Y-%m-%d %H:%M:%S %Z (%z)' 2>/dev/null || echo "Invalid timestamp format")"
	echo "Mountain:               $(TZ=America/Denver gdate -d "$utc_timestamp UTC" '+%Y-%m-%d %H:%M:%S %Z (%z)' 2>/dev/null || echo "Invalid timestamp format")"
	echo "Mountain (No DST):      $(TZ=America/Phoenix gdate -d "$utc_timestamp UTC" '+%Y-%m-%d %H:%M:%S %Z (%z)' 2>/dev/null || echo "Invalid timestamp format")"
	echo "Pacific:                $(TZ=America/Los_Angeles gdate -d "$utc_timestamp UTC" '+%Y-%m-%d %H:%M:%S %Z (%z)' 2>/dev/null || echo "Invalid timestamp format")"
}

# Convert local timestamp to UTC
function tutc() {
	if [ $# -eq 0 ]; then
		echo "Usage: tutc 'YYYY-MM-DD HH:MM:SS' [timezone]"
		echo "Example: tutc '2025-08-15 16:21:00'"
		echo "Example: tutc '2025-08-15 16:21:00' 'America/New_York'"
		echo "If no timezone specified, uses local timezone"
		return 1
	fi
	
	local timestamp="$1"
	local timezone="${2:-$(date +%Z)}"
	
	echo "Converting to UTC:"
	echo "=================="
	
	# Convert the input timezone to a proper TZ format if it's a common abbreviation
	case "$timezone" in
		"CDT"|"CST") timezone="America/Chicago" ;;
		"EDT"|"EST") timezone="America/New_York" ;;
		"MDT"|"MST") timezone="America/Denver" ;;
		"PDT"|"PST") timezone="America/Los_Angeles" ;;
		"UTC"|"GMT") timezone="UTC" ;;
	esac
	
	# Get the timezone offset for display
	local offset_info=$(TZ="$timezone" gdate -d "$timestamp" "+%z" 2>/dev/null)
	if [ $? -eq 0 ] && [ -n "$offset_info" ]; then
		# Format the offset for display (remove the colon and add sign)
		local offset_display=${offset_info:0:3}
		if [ "${offset_info:0:1}" = "+" ]; then
			offset_display="+${offset_info:1:2}"
		else
			offset_display="${offset_info:0:3}"
		fi
		echo "Input time: $timestamp $offset_display ($timezone)"
	else
		echo "Input time: $timestamp ($timezone)"
	fi
	
	echo "UTC time:   $(TZ=UTC gdate -d "$timestamp" '+%Y-%m-%d %H:%M:%S %Z (%z)' 2>/dev/null || echo "Invalid timestamp format")"
}
