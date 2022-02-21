menuOpen = false 

Dialog = {
	Title = "DialogUI", -- FR: Titre du DialogUI / EN: Title of DialogUI
	Number = 4, -- FR: Nombre de branche (4 max) / EN: Number of Branch (4 max)
	Menu = {
		{
			ButtonName = "Change title",
			Selected = function(currentIndex)
				DialogUI:SetTitle("Title changed")
			end
		},
		{
			ButtonName = "Rename button",
			Selected = function(currentIndex)
				DialogUI:renameButton(currentIndex, 'Renamed button')
			end
		},
		{
			ButtonName = "Close the menu",
			Selected = function(currentIndex)
				DialogUI:CloseMenu()
			end
		},
		{
			ButtonName = "Just a button",
			Selected = function(currentIndex)
				Optionals:Notification("DialogUI was created by Yatox and AigleIsBack")
			end
		}
	}
}

Controls:create(Options.Menu.KeyRegister, Options.Menu.KeyRegister, "DialogUI", function()
	if not DialogUI:checkMenu() then 
		menuOpen = true 
	end
end)

CreateThread(function()
    while true do
		if menuOpen then 
			DialogUI:CreateMenuDialogUI(Dialog, function(selected)
				for i = 1, Dialog.Number do 
					if i == selected then 
						Dialog.Menu[i].Selected(selected)
					end
				end
			end)
			Wait(1)
		else
			Wait(120)
		end
	end
end)
