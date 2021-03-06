(*  use "hw1test.sml";   *)

val date1 = (2014,10,08)
val date2 = (2013,11,4)
val dates = [date1, date2]

fun is_older (date1 : int*int*int, date2 : int*int*int) =
     (#1 date1) * 10000 + (#2 date1) * 100 + (#3 date1) < (#1 date2) * 10000
     + (#2 date2) * 100 + (#3 date2)

fun number_in_month (dates : (int * int * int) list, month : int) =
	if null dates
	then 0
	else 
		if (#2 (hd dates)) = month
		then 1 + number_in_month(tl dates, month)
		else number_in_month(tl dates, month)

fun number_in_months (dates : (int * int * int) list, months : int list) = 
	if null months
	then 0
	else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month(dates : (int * int * int) list, month : int) =
	if null dates
	then []
	else 
		if (#2 (hd dates)) = month
		then hd dates :: dates_in_month(tl dates, month)
		else dates_in_month(tl dates, month)

fun dates_in_months (dates : (int * int * int) list, months : int list) =
	if null months
	then []
	else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (items : string list, n : int) =
	if n = 1
	then hd items
	else get_nth(tl items, n-1)

fun date_to_string(date : int*int*int) =
	let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	in get_nth (months, #2 date) ^ " " ^ Int.toString(#3 date)^ ", " ^ Int.toString(#1 date)
	end

fun number_before_reaching_sum (sum : int, numbers : int list) =
	if null (tl numbers)
	then 0
	else
		if sum <= hd numbers + hd (tl numbers)
		then 1
		else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers)

fun what_month (day : int) =
	if day < 32
	then 1
	else number_before_reaching_sum (day, [31,28,31,30,31,30,31,31,30,31,30,31]) + 1 

fun month_range(day1 : int, day2 : int) = 
	let val day_mid = day1 + 1
	in if day1 > day2
		then []
		else what_month(day1) :: month_range(day_mid, day2)
	end

(*fun oldest (dates : int list) =
	if null dates
	then NONE
	else
		let val tl_ans = oldest(tl dates)
		in if isSome tl_ans andalso is_older ( hd dates, hd dates )
			then tl_ans
			else SOME (hd dates)
		end*)

fun oldest(dates :(int*int*int) list) =
	if null dates
	then NONE
	else
		if null (tl dates)
		then SOME (hd dates)
		else if is_older(hd dates, hd (tl dates))
			then oldest(hd dates :: tl (tl dates))
			else oldest(tl dates)

(*	if is_older(hd dates, (hd (tl dates)))
	then oldest (hd dates :: (hd (tl dates))
	else oldest(tl dates)*)



(*11. Write a function oldest that takes a list of dates and evaluates to an (int*int*int) option. It
evaluates to NONE if the list has no dates and SOME d if the date d is the oldest date in the list.
*)









