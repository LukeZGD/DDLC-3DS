function menu_enable(m, x)
	menu_type = m
	menu_items = x
	menu_enabled = true
	if m_type ~= 'help' then m_selected = 2 end
	m_select()
end

function menu_draw()
	love.graphics.setColor(255, 255, 255, alpha)
	love.graphics.draw(background_Image, posX, posY)
	
	love.graphics.setColor(255, 189, 225, alpha)
	if menu_items == 4 then
		love.graphics.rectangle("fill", 16, 45, 100, 16 )
		love.graphics.rectangle("fill", 16, 70, 100, 16 )
		love.graphics.rectangle("fill", 16, 95, 100, 16 )
	elseif menu_items == 5 then
		love.graphics.rectangle("fill", 16, 45, 100, 16 )
		love.graphics.rectangle("fill", 16, 70, 100, 16 )
		love.graphics.rectangle("fill", 16, 95, 100, 16 )
		love.graphics.rectangle("fill", 16, 120, 100, 16 )
	elseif menu_items == 8 then
		love.graphics.rectangle("fill", 16, 45, 100, 16 )
		love.graphics.rectangle("fill", 16, 70, 100, 16 )
		love.graphics.rectangle("fill", 16, 95, 100, 16 )
		love.graphics.rectangle("fill", 16, 120, 100, 16 )
		love.graphics.rectangle("fill", 16, 145, 100, 16 )
		love.graphics.rectangle("fill", 16, 170, 100, 16 )
		love.graphics.rectangle("fill", 16, 195, 100, 16 )
	end
	
	love.graphics.setColor(0,0,0)
	love.graphics.print('>',cX,cY,0,1,1)
	
	if menu_type == 'title' then
		love.graphics.print("Main Menu:",16, 20, 0, 1, 1)
		love.graphics.print("New Game",16, 45, 0, 1, 1)
		love.graphics.print("Load Game",16, 70, 0, 1, 1)
		love.graphics.print("Settings",16, 95, 0, 1, 1)
		love.graphics.print("Help",16, 120, 0, 1, 1)
		
	elseif menu_type == 'help' then
		love.graphics.print("Controls:",16, 20, 0, 1, 1)
		love.graphics.print("Y - Save Game",16, 45, 0, 1, 1)
		love.graphics.print("B - Auto On/Off",16, 70, 0, 1, 1)
		love.graphics.print("X - Skip",16, 95, 68, 1, 1)
		
	elseif menu_type == 'loadgame' then
		love.graphics.print("Load Game:",16, 20, 0, 1, 1)
		love.graphics.print("Save File 1",16, 45, 0, 1, 1)
		love.graphics.print("Save File 2",16, 70, 0, 1, 1)
		love.graphics.print("Save File 3",16, 95, 68, 1, 1)
		
	elseif menu_type == 'savegame' then
		love.graphics.print("Save Game:",16, 20, 0, 1, 1)
		love.graphics.print("Save File 1",16, 45, 0, 1, 1)
		love.graphics.print("Save File 2",16, 70, 0, 1, 1)
		love.graphics.print("Save File 3",16, 95, 68, 1, 1)
		
	elseif menu_type == 'pause' then
		love.graphics.print("Pause Menu:",16, 20, 0, 1, 1)
		love.graphics.print("Save Game",16, 45, 0, 1, 1)
		love.graphics.print("Load Game",16, 70, 0, 1, 1)
		love.graphics.print("Main Menu",16, 95, 68, 1, 1)
		love.graphics.print("Settings",16, 120, 68, 1, 1)
		love.graphics.print("Help",16, 145, 68, 1, 1)
		love.graphics.print("Quit",16, 170, 68, 1, 1)
		love.graphics.print("Return",16, 195, 68, 1, 1)
	end
end

function menu_confirm()

	if menu_type == 'title' then --title screen options
		sfx1:play()
		
		if m_selected == 2 then --new game
			if player == "" then
				love.keyboard.setTextInput(true)
			elseif ch0ln == 10001 then
				menu_enabled = false
				audioUpdate('2')
				xaload = 0
				state = "game"
			elseif ch0ln <= 9999 then
				hideSayori()
				hideYuri()
				hideNatsuki()
				hideMonika()
				menu_enabled = false
				ch0ln = 1
				xaload = 0
				state = "game"
			end
			
		elseif m_selected == 3 then --load game
			menu_previous = 'title'
			menu_previousitems = 5
			menu_enable('loadgame', 4)
			m_selected = 2
			
		elseif m_selected == 4 then --settings
		
		elseif m_selected == 5 then --help
			menu_previous = 'title'
			menu_previousitems = 5
			menu_enable('help', 4)
			m_selected = 0
			m_select()
		end
		
	elseif menu_type == 'loadgame' then --load game screen 
		sfx1:play()
		if player ~= "" and ch0ln ~= 0 then
			savenumber = m_selected - 1
			if love.filesystem.isFile("save"..savenumber..".sav") then
				loadgame()
				loadupdate()
				state = "game"
				menu_enabled = false
			end
		end
		
	elseif menu_type == 'savegame' then  --save game screen 
		savenumber = m_selected - 1
		savegame()
		sfx1:play()
		menu_enabled = false
	
	elseif menu_type == 'pause' then
		sfx1:play()
		if m_selected == 2 then
			menu_previous = 'pause'
			menu_previousitems = 8
			menu_enable('savegame',4)
		elseif m_selected == 3 then
			menu_previous = 'pause'
			menu_previousitems = 8
			menu_enable('loadgame',4)
		elseif m_selected == 6 then
			menu_previous = 'pause'
			menu_previousitems = 8
			menu_enable('help',4)
			m_selected = 0
		elseif m_selected == 8 then
			menu_enabled = false
		end
	end
end

function m_select()
	if m_selected == 0 then
		cX = -10
		cY = -10
	elseif m_selected == 2 then
		cX = 8
		cY = 45
	elseif m_selected == 3 then
		cX = 8
		cY = 70
	elseif m_selected == 4 then
		cX = 8
		cY = 95
	elseif m_selected == 5 then
		cX = 8
		cY = 120
	elseif m_selected == 6 then
		cX = 8
		cY = 145
	elseif m_selected == 7 then
		cX = 8
		cY = 170
	elseif m_selected == 8 then
		cX = 8
		cY = 195
	end
end

function menu_keypressed(key)
	if key == 'down' then
		sfx2:play()
		if m_selected <= menu_items-1 then
			m_selected = m_selected + 1
			m_select()
		end
	elseif key == 'up' then
		sfx2:play()
		if m_selected >= 3 then
			m_selected = m_selected - 1
			m_select()
		end
	elseif key == 'a' then
		menu_confirm()
	elseif key == 'b' then
		if menu_type == 'savegame' or menu_type == 'loadgame' or menu_type == 'help' then
			sfx1:play()
			menu_enable(menu_previous, menu_previousitems)
		elseif menu_type == 'pause' then
			menu_enabled = false
		end
	end
end