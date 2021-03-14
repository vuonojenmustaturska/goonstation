/var/list/timers = list()
/var/datum/controller/timers/timers_controller


/datum/controller/timers
	var/list/queued_timers

/datum/controller/timers/New()
	//call(RUST_G, "setup_timers")()
	loopytime()

/datum/controller/timers/proc/loopytime()
	set waitfor = FALSE
	while (TRUE)
		doWork()
		sleep(1)

/datum/controller/timers/proc/doWork()
	var/expired_raw = call(RUST_G, "get_timers")()
	var/list/expired_timers = splittext(expired_raw, ",")
	for (var/timerref in expired_timers)
		var/list/timer = timers[timerref]
		if (timer[TIMER_OBJ] == GLOBAL_PROC)
			call(timer[TIMER_DELEGATE])(arglist(timer[TIMER_ARGS]))
		else
			call(timer[TIMER_OBJ], timer[TIMER_DELEGATE])(arglist(timer[TIMER_ARGS]))
		timers -= timerref
