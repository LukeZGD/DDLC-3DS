require "draw"
require "resources"
require "saveload"
require "menu"

function love.load() 
	dversion = "v0.0.2"

	love.graphics.setBackgroundColor(0,0,0)	
	myTextStartTime = love.timer.getTime()
	l_timer = 96
	timer = 0
	autotimer = 0
	xaload = 0
	alpha = 255
	
	posX = -75
	posY = 0
	
	menu_enabled = false
	
	--os detection
	global_os = love.system.getOS()
	if global_os ~= 'Horizon' then 
		love.window.setMode(400, 480) 
		love.window.setTitle('DDLC-3DS')
	end
	
	changeState('load')
end

function love.draw() 
	if state == 'load' then
		drawLoad()
	elseif state == 'splash1' or state == "splash2" or state == "title" then --title (Title Screen)
		drawSplash()
	elseif state == "game" or state == "newgame" then --game (Ingame)
		drawGame()
	elseif state == "poemgame" then
		drawPoemGame()
	elseif state == "s_kill_early" then --early act 1 end
		drawTopScreen()
		love.graphics.setBackgroundColor (245,245,245)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(endbg,0,0)
		drawBottomScreen()
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(s_killearly,32,0)
	end
end

function love.update(dt)
	if global_os == 'Horizon' then
		posX = posX - 0.25
		posY = posY - 0.25
		if posX <= -80 then posX = 0 end
		if posY <= -80 then posY = 0 end
	end

	--update depending on state
	if state == "load" then
		updateLoad(dt)
	elseif state == 'splash1' or state == 'splash2' or state == 'title' then
		updateSplash(dt)
	elseif state == 'game' or state == 'newgame' then
		updateGame(dt)
	elseif state == 'poemgame' then
		updatePoemGame(dt)
	end
end

function love.keypressed(key)	
	if state == 'game' and menu_enabled == false then
		game_keypressed(key)
	elseif state == 'newgame' and menu_enabled == false then
		newgame_keypressed(key)
	elseif state == 'poemgame' and menu_enabled == false then
		poemgamekeypressed(key)
	elseif menu_enabled then
		menu_keypressed(key)
	end
end

function love.keyreleased(key)
	if key == 'x' then --skip disable
		if tspd ~= nil then settings.textspd = tspd end
		tspd = nil
		autotimer = 0
	end
end

function love.textinput(text)
	if global_os == 'Horizon' then
		if text ~= '' then 
			player = text
			savegame()
			changeState('game',1)
		else
			state = "title"
		end
	end
end
