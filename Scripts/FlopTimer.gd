extends Timer

func resetTimer():
	wait_time = getRandomTime()

func getRandomTime():
	var randomFlopTime = rand_range(1,2)
	print(randomFlopTime)
	return randomFlopTime
