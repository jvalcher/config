
# Commands

	# ls  ->  layout src
	# rr  ->  run + record (allows for reverse commands below)
	# p var1  ->  print current value of var1
	# n, rn  ->  next, reverse-next  (skip over function calls in other files)
	# s, rs  ->  step, reverse-step	 (move to other files for function calls)
	# c, rc  ->  continue, reverse continue	(to next breakpoint)
	# dl  ->  directory + ls  (load new source file, refresh src view)
	# q  ->  quit with no prompt


set confirm on

define ls
	layout src
	refresh
end

define rr
	run
	record
	refresh
end

define n
	next
	refresh
end

define rn
	reverse-next
	refresh
end

define s
	step
	refresh
end

define rs
	reverse-step
	refresh
end

define c
	continue
	refresh
end

define rc
	reverse-continue
	refresh
end

define dl
	set confirm off
	directory
	ls
	set confirm on
end	

define q
	set confirm off
	quit
end
