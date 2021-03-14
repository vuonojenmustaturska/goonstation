#define TIMER(OBJ, DELEGATE, ARGS...) list(OBJ, DELEGATE, list(##ARGS))
#define TIMER_OBJ 1
#define TIMER_DELEGATE 2
#define TIMER_ARGS 3

/proc/add_byond_timer(list/timer, duration)
	boutput(world, "Byondtime timer added: [json_encode(list(timer, duration))]")
	var/timerref = "\ref[timer]"
	timers[timerref] = timer
	return call(RUST_G, "add_byondtime_timer")(timerref, "[duration]")

/proc/add_real_timer(list/timer, duration)
	boutput(world, "Realtime timer added: [json_encode(list(timer, duration))]")
	var/timerref = "\ref[timer]"
	timers[timerref] = timer
	return call(RUST_G, "add_realtime_timer")(timerref, "[duration]")

/proc/test_add_real_timer(foo, time)
	add_real_timer(TIMER(GLOBAL_PROC, .proc/boutput, world, foo), time)

/proc/test_timers()
	. = list()
	. += add_byond_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a byond timer test @ 20 ticks, it was queued at [world.time]"), 2 SECONDS)
	. += add_real_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a realtime timer test @ 1 second, it was queued at [world.time]"), 1 SECONDS)
	. += add_real_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a realtime timer test @ 2 second, it was queued at [world.time]"), 2 SECONDS)
	. += add_real_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a realtime timer test @ 3 second, it was queued at [world.time]"), 3 SECONDS)
	. += add_real_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a realtime timer test @ 4 second, it was queued at [world.time]"), 4 SECONDS)
	. += add_real_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a realtime timer test @ 5 second, it was queued at [world.time]"), 5 SECONDS)
	. += add_byond_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a byond timer test @ 13 ticks, it was queued at [world.time]"), 13)
	. += add_byond_timer(TIMER(GLOBAL_PROC, .proc/boutput2, world, "Hello this is a byond timer test @ 17 ticks, it was queued at [world.time]"), 17)


/proc/boutput2(target, msg)
	boutput(target, "([world.time]) ([time2text(world.timeofday,"hh:mm:ss")]) [msg]")
