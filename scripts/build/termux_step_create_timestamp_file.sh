termux_step_create_timestamp_file() {
	TERMUX_BUILD_TS_FILE=$TERMUX_PKG_TMPDIR/timestamp_$TERMUX_PKG_NAME
	touch "$TERMUX_BUILD_TS_FILE"
}

termux_step_post_create_timestamp_file() {
	# Keep track of when build started so we can see what files
	# have been created.  We start by sleeping so that any
	# generated files (such as zlib.pc) get an older timestamp
	# than the TERMUX_BUILD_TS_FILE.
	local now created
	now="$(date "+%s%N")"
	created="$(date -r "$TERMUX_BUILD_TS_FILE" "+%s%N")"
	delay="$(( (now - created) / 1000000 ))"
	echo $delay
	(( delay >= 1000 )) || sleep "0.$delay"
}
