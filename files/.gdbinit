
# Commands

	# ls  ->  layout src
	# rr  ->  run + record
	# p var1  ->  print current value of variable var1
	# n, rn  ->  next, reverse-next  (skip over function calls in other files)
	# s, rs  ->  step, reverse-step	 (move to other files)
	# c, rc  ->  continue, reverse continue


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
