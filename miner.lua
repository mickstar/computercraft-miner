--all code is released as public domain without a license
--Michael Johnston 10 jan 2015
MINELENGTH = 40

function init()
	if turtle.getItemCount(1) == 0 then
		print "Put torches in slot 1"
		shell.exit()
	end
	if turtle.getItemCount(2) == 0 then
		print "Put cobblestone in slot 2"
		shell.exit()
	end
	if turtle.getItemCount(16) == 0 then
		print "Put coal in slot 16"
		shell.exit()
	end
	

function performMine()
	refuelIfNeeded()
	while turtle.detect() do
		turtle.dig()
	end
	turtle.forward()
	while turtle.detectUp() do
		turtle.digUp()
	end
	if not turtle.detectDown() then
		turtle.select(2)
		turtle.placeDown()
	end
end

function placeTorch ()
	turtle.select(1)
	turtle.up()
	turtle.turnLeft()
	while turtle.detect()  do
		turtle.dig()
	end
	turtle.place()
	turtle.turnRight()
	turtle.down()
end

function performStrip()
	for x=1,MINELENGTH do
		performMine()
		if x % 10 == 0 then
			placeTorch()
		end
	end
	turtle.turnLeft()
	turtle.turnLeft()
	turtle.up()
	for x=1,MINELENGTH do
		if (turtle.detectUp()) then
			turtle.select(2)
			turtle.placeUp()
		end
		turtle.forward()
	end
end

function refuelIfNeeded()
	if turtle.getFuelLimit < 10 then
		turtle.select (16)
		if turtle.getItemCount(16) < 16 then
			print "put more fuel in"
		end
		turtle.refuel(16)
	end
end

function dig()
	while turtle.detect() do
		turtle.dig()
	end
end

function prepareStrip()
	turtle.turnLeft()
	dig()
	turtle.forward()
	turtle.digDown()
	turtle.down()
	turtle.turnLeft()
end

performStrip()
prepareStrip()
performStrip()
prepareStrip()