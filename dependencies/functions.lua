DialogUI = {}

function DialogUI:checkMenu()
	return self.IsVisible 
end

function DialogUI:CloseMenu()
	menuOpen = false 
	self.IsVisible = false
	self.Base = {}
	self.Menu = {}
	self.Base.Selected = 0
end

function DialogUI:SetTitle(Title)
	self.Base.Title = Title
end

function DialogUI:renameButton(buttonIndex, newName)
	self.Menu[buttonIndex].ButtonName = newName
end

function DialogUI:KeyTick()
	if self.Base.Selected ~= 0 and IsControlJustPressed(2, 223) then
		local selectedLine, stayOpen = self.Menu[self.Base.Selected]
		if self.Base.Callback and selectedLine and not selectedLine.fail then
			stayOpen = DialogUI.Base.Callback(DialogUI.Base.Selected)
		end
		if Options.Menu.AutoClose == true then 
			if not stayOpen then
				self:CloseMenu()
			end
		end
	end
	if IsControlJustPressed(2, 177) then
		self:CloseMenu()
	end
end

function DialogUI:DrawTick()
	if not self.IsVisible then return end
	Optionals:StreamTexture()
	Optionals:CreateDraw({0.5, 0.9, 1.0, 0.25, 0, 0, 0, 110})
	self.Base.Selected = 0
	if Options.Menu.AddLogo then 
		DrawSprite("DialogUI_", "logo", 0.5, 0.805, 0.015, 0.03, 0.0, 255, 255, 255, 1000)
	end
	Optionals:DrawText(1, self.Base.Title or "DialogUI", 0.6, 0.5, 0.825, {255, 255, 255}, true, 0)
	for i = 1, self.Base.Number do
		local Line, belowLine = i == 2 or i == 3, i > 2
		local X, Y = Line and 0.4875 + 0.025 or 0.4875, belowLine and 0.892 + 0.045 or 0.892
		if Optionals:IsMouseInBounds(X + (Line and 0.14 or -0.14), Y, 0.25, 0.04) then
			self.Base.Selected = i
		end
		DrawSprite("helicopterhud", "hud_corner", X, Y, 0.025, 0.05, -90.0 + 90.0 * i, Options.Menu.ColorOfBranch[1], Options.Menu.ColorOfBranch[2], Options.Menu.ColorOfBranch[3], 255)
		if self.Menu[i] then
			DrawSprite("helicopterhud", "hud_line", X + (Line and 0.025 * 0.45 or - 0.4875 * 0.025), Y, 0.015, 0.004, 180.0, Options.Menu.ColorOfBranch[1], Options.Menu.ColorOfBranch[2], Options.Menu.ColorOfBranch[3], 255)
			Optionals:DrawText(4, (self.Base.Selected == i and Options.Menu.SelectedColor or "") .. self.Menu[i].ButtonName, 0.425, X - (Line and -0.4875 or 0.4875) * 0.04, Y - 0.0175, {255, 255, 255}, true, Line and 1 or 2)
		end
	end
end

function DialogUI:CreateMenuDialogUI(table, callback)
	if self.IsVisible then 
		return 
	end
	self.Base = self.Base or {}
	self.Menu = table.Menu or {}
	self.Base.Title = table.Title
	self.Base.Number = table.Number
	self.Base.Callback = callback
	self.IsVisible = true
	CreateThread(function()
		while DialogUI.IsVisible do
			Wait(0)
			DialogUI:DrawTick()
			DialogUI:KeyTick()
		end
	end)
end