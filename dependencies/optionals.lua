Optionals = {}

function Optionals:IsMouseInBounds(X, Y, Width, Height)
	local MX, MY = GetControlNormal(0, 239) + Width / 2, GetControlNormal(0, 240) + Height / 2
	return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function Optionals:AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end

function Optionals:DrawText(intFont, strText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)
	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end
	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end
	SetTextEntry("jamyfafi")
	Optionals:AddLongString(strText)
	DrawText(intPosX, intPosY)
end

function Optionals:KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	BlockInput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
		BlockInput = false
        return result
    else
        Wait(500)
		BlockInput = false
        return nil
    end
end

function Optionals:Prompt(txt, typeSpinner)
	BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName(txt)
    EndTextCommandBusyspinnerOn(typeSpinner or 1)
end

function Optionals:Subtitle(txt)
	ClearPrints()
	BeginTextCommandPrint("STRING")
	AddTextComponentSubstringPlayerName(txt)
end

function Optionals:NotificationHelp(txt)
    AddTextEntry('HelpNotification', txt)
    DisplayHelpTextThisFrame('HelpNotification', false)
end

function Optionals:Notification(txt)
    SetNotificationTextEntry('STRING') 
    AddTextComponentSubstringPlayerName(txt) 
    DrawNotification(false, true) 
end

function Optionals:UpdateSettings()
	SetMouseCursorActiveThisFrame()
	HideHudAndRadarThisFrame()
	DisableControlAction(0, 1, true)
	DisableControlAction(0, 2, true)
	DisableControlAction(0, 24, true)
	DisableControlAction(0, 25, true)
end

function Optionals:CreateDraw(args)
	Optionals:UpdateSettings()
	return DrawRect(args[1], args[2], args[3], args[4], args[5] ,args[6] ,args[7] ,args[8])
end

function Optionals:StreamTexture() 
	while not HasStreamedTextureDictLoaded("helicopterhud") or not HasStreamedTextureDictLoaded("DialogUI_") do 
		RequestStreamedTextureDict("helicopterhud")
		RequestStreamedTextureDict("DialogUI_")
		Wait(10)
	end
end