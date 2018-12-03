local l_timer = 94
local err = ''
local savedir
local errtime = 0

function drawLoad()
	lg.setColor(0,0,0,alpha)
	lg.rectangle('fill',0,0,1280,725)
	lg.setColor(255,255,255)
	lg.print(err,10,10)
end

function updateLoad()
	if l_timer < 99 then
		l_timer = l_timer + 1
	end
	
	--loading assets
	if l_timer == 95 then
		m1 = lg.newFont('fonts/m1.ttf',28)
		y1 = lg.newFont('fonts/y1.ttf',30)
		allerfont = lg.newFont('fonts/Aller_Rg.ttf',22)
		lg.setFont(allerfont)
		
	elseif l_timer == 96 then
		s1 = lg.newFont('fonts/s1.ttf',32)
		n1 = lg.newFont('fonts/n1.ttf',26)
		deffont = lg.newFont('fonts/VerilySerifMono.ttf',23)
		halogenfont = lg.newFont('fonts/Halogen.ttf',28)
		rifficfont = lg.newFont('fonts/RifficFree-Bold.ttf',24)
		
	elseif l_timer == 97 then
		sfx1 = love.audio.newSource('audio/sfx/select'..audio_ext, 'static')
		sfx2 = love.audio.newSource('audio/sfx/hover'..audio_ext, 'static')
		keysbox = lg.newImage("images/gui/box.png")
		menu_bg_m = lg.newImage("images/bg/Menu_bg_m.png")
		
	elseif l_timer == 98 then
		--splash, title screen, gui elements, sfx
		namebox = lg.newImage('images/gui/namebox.png')
		textbox = lg.newImage('images/gui/textbox.png')
		background_Image = lg.newImage('images/gui/menu_bg.png')
		guicheck = lg.newImage('images/gui/check.png')
		gui_ctc = lg.newImage('images/gui/ctc.png')
		gui_skip = lg.newImage('images/gui/skip.png')
		sidebar = lg.newImage('images/gui/sidebar.png')
		
	elseif l_timer == 99 then
		local file = love.filesystem.getInfo('persistent')
		if file then
			checkLoad()
		else
			changeState('newgame')
		end
	elseif l_timer == 100 then
		lg.setBackgroundColor(255,255,255)
		alpha = math.max(alpha - 5, 0)
		if alpha == 0 then
			changeState('splash')
		end
	end
end

function checkLoad()
	if love.filesystem.getInfo('persistent') then
		loadpersistent()
	end
	
	if love.filesystem.getInfo('settings.sav') then
		loadsettings()
		if not settings.masvol then
			settings = {textspd=100,autospd=4,masvol=70,bgmvol=70,sfxvol=70}
			savesettings()
		end
		game_setvolume()
	end
	
	if g_system == 'Switch' then
		savedir = 'sdmc:/switch/DDLC-LOVE/'
	elseif g_system == 'Vita' then
		savedir = 'ux0:/data/DDLC-LOVE/savedata/'
	elseif g_system == 'PSP' then
		savedir = 'ms0:/data/DDLC-LOVE/savedata/'
	else
		savedir = '%appdata%\\LOVE\\DDLC-LOVE\\'
	end
	
	os_timecheck = nil
	
	
	local ghostmenu_chance = love.math.random(0, 63)
	if not persistent.act2 then
		err = [[
		Error!
		Old save data detected, and it is not compatible with this version of DDLC-LOVE.
		Please delete all save data and try again.
		
		Delete persistent and save files in here:
		> ]]..savedir..'\n\nPress Y to quit'
	elseif persistent.chr.s == 0 and persistent.ptr == 0 then
		changeState('s_kill_early')
	elseif ghostmenu_chance == 0 and persistent.ptr == 2 and persistent.chr.s == 0 then
		changeState('ghostmenu')
		persistent.chr.s = 2
		savepersistent()
	elseif persistent.chr.m == 2 then
		changeState('game','autoload')
	elseif os_timecheck then
		love.math.setRandomSeed(os.time())
		l_timer = 100
	else
		err = [[
		Warning!
		os.time() returned nil
		
		Your device might have never been online, or this is just a bug that I won't be able to fix
		The game will still launch, but some stuff that rely on random might be broken
		
		Press A to continue
		Press Y to quit
		]]
		errtime = 1
	end
end

function loadkeypressed(key)
	if key == 'y' then
		love.event.quit()
	elseif key == 'a' and errtime == 1 then
		l_timer = 100
	end
end