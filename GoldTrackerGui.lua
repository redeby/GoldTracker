-- Get the window manager for later creation if dynamic labels for gui xml file
local wm = GetWindowManager()

-- Define used colors
local colorPlayerName = ZO_ColorDef:New("00EB75")
local colorPlayerNameDimmed = ZO_ColorDef:New("00A05D")
local colorText = ZO_ColorDef:New("AAAA87")
local colorTextDimmed = ZO_ColorDef:New("6E6E5A")
local colorTextAll = ZO_ColorDef:New("4D6AFF")
local colorIncome = ZO_ColorDef:New("36C844")
local colorIncomeDimmed = ZO_ColorDef:New("289E32")
local colorExpense = ZO_ColorDef:New("E02513")
local colorExpenseDimmed = ZO_ColorDef:New("8A160B")
local colorBalance = ZO_ColorDef:New("BE9500")
local colorBalanceDimmed = ZO_ColorDef:New("795F00")


-------------------------------------------------------------------------------
-- Overview Gui functions
-------------------------------------------------------------------------------
function GoldTracker.UpdatePlayerName()
	GoldTrackerGuiOverviewPlayerName:SetText(GetUnitName("Player"))
	GoldTrackerGuiOverviewPlayerName:SetColor(colorPlayerName:UnpackRGBA())
end

function GoldTracker.UpdateStartGoldLastReset()
	GoldTrackerGuiOverviewStartGoldLastResetLabel:SetColor(colorText:UnpackRGBA())
	GoldTrackerGuiOverviewStartGoldLastReset:SetText(string.format(GoldTracker.savedVariables.resetBalance .. "g"))
	GoldTrackerGuiOverviewStartGoldLastReset:SetColor(colorBalance:UnpackRGBA())
end

function GoldTracker.UpdateGoldInLastReset()
	GoldTracker.savedVariables.income=GoldTracker.savedVariables.income+GoldTracker.diff
	GoldTrackerGuiOverviewGoldInLastResetLabel:SetColor(colorText:UnpackRGBA())
	GoldTrackerGuiOverviewGoldInLastReset:SetText(string.format(GoldTracker.savedVariables.income .. "g"))
	GoldTrackerGuiOverviewGoldInLastReset:SetColor(colorIncome:UnpackRGBA())
end

function GoldTracker.UpdateGoldOutLastReset()
	GoldTracker.savedVariables.expenses=GoldTracker.savedVariables.expenses+GoldTracker.diff
	GoldTrackerGuiOverviewGoldOutLastResetLabel:SetColor(colorText:UnpackRGBA())
	GoldTrackerGuiOverviewGoldOutLastReset:SetText(string.format(GoldTracker.savedVariables.expenses .. "g"))
	GoldTrackerGuiOverviewGoldOutLastReset:SetColor(colorExpense:UnpackRGBA())
end

function GoldTracker.UpdateStartGoldThisSession()
	GoldTrackerGuiOverviewStartGoldThisSessionLabel:SetColor(colorText:UnpackRGBA())
	GoldTrackerGuiOverviewStartGoldThisSession:SetText(string.format(GoldTracker.StartGoldThisSession .. "g"))
	GoldTrackerGuiOverviewStartGoldThisSession:SetColor(colorBalance:UnpackRGBA())
end

function GoldTracker.UpdateGoldInThisSession()
	GoldTracker.GoldInThisSession=GoldTracker.GoldInThisSession+GoldTracker.diff
	GoldTrackerGuiOverviewGoldInThisSessionLabel:SetColor(colorText:UnpackRGBA())
	GoldTrackerGuiOverviewGoldInThisSession:SetText(string.format(GoldTracker.GoldInThisSession .. "g"))
	GoldTrackerGuiOverviewGoldInThisSession:SetColor(colorIncome:UnpackRGBA())
end

function GoldTracker.UpdateGoldOutThisSession()
	GoldTracker.GoldOutThisSession=GoldTracker.GoldOutThisSession+GoldTracker.diff
	GoldTrackerGuiOverviewGoldOutThisSessionLabel:SetColor(colorText:UnpackRGBA())
	GoldTrackerGuiOverviewGoldOutThisSession:SetText(string.format(GoldTracker.GoldOutThisSession .. "g"))
	GoldTrackerGuiOverviewGoldOutThisSession:SetColor(colorExpense:UnpackRGBA())
end

function GoldTracker.UpdateBalance()
	GoldTrackerGuiOverviewBalanceLabel:SetColor(colorText:UnpackRGBA())
	GoldTrackerGuiOverviewBalance:SetText(string.format(GetCurrentMoney() .. "g"))
	GoldTrackerGuiOverviewBalance:SetColor(colorBalance:UnpackRGBA())
end

function GoldTracker.UpdateAllLastReset()
	local sum=0
	for i=1, #GoldTracker.savedVariablesAccount.charlist do
		charactername=GoldTracker.savedVariablesAccount.charlist[i];
		GoldTracker.savedVariablesAlt = ZO_SavedVars:New("GoldTrackerSavedVariables", 1, nil, LastResetDefaults, "Default", GetDisplayName(), charactername);
		sum = sum + GoldTracker.savedVariablesAlt.resetBalance;
	end
	GoldTrackerGuiOverviewAllLastResetLabel:SetColor(colorTextAll:UnpackRGBA())
	GoldTrackerGuiOverviewAllLastReset:SetText(string.format(sum .. "g"))
	GoldTrackerGuiOverviewAllLastReset:SetColor(colorBalance:UnpackRGBA())
end

function GoldTracker.UpdateAllIncome()
	local sum=0
	for i=1, #GoldTracker.savedVariablesAccount.charlist do
		charactername=GoldTracker.savedVariablesAccount.charlist[i];
		GoldTracker.savedVariablesAlt = ZO_SavedVars:New("GoldTrackerSavedVariables", 1, nil, LastResetDefaults, "Default", GetDisplayName(), charactername);
		sum = sum + GoldTracker.savedVariablesAlt.income;
	end
	GoldTrackerGuiOverviewAllIncomeLabel:SetColor(colorTextAll:UnpackRGBA())
	GoldTrackerGuiOverviewAllIncome:SetText(string.format(sum .. "g"))
	GoldTrackerGuiOverviewAllIncome:SetColor(colorIncome:UnpackRGBA())
end

function GoldTracker.UpdateAllExpenses()
	local sum=0
	for i=1, #GoldTracker.savedVariablesAccount.charlist do
		charactername=GoldTracker.savedVariablesAccount.charlist[i];
		GoldTracker.savedVariablesAlt = ZO_SavedVars:New("GoldTrackerSavedVariables", 1, nil, LastResetDefaults, "Default", GetDisplayName(), charactername);
		sum = sum + GoldTracker.savedVariablesAlt.expenses;
	end
	GoldTrackerGuiOverviewAllExpensesLabel:SetColor(colorTextAll:UnpackRGBA())
	GoldTrackerGuiOverviewAllExpenses:SetText(string.format(sum .. "g"))
	GoldTrackerGuiOverviewAllExpenses:SetColor(colorExpense:UnpackRGBA())
end

function GoldTracker.UpdateAllBank()
	GoldTrackerGuiOverviewAllBankLabel:SetColor(colorTextAll:UnpackRGBA())
	GoldTrackerGuiOverviewAllBank:SetText(string.format(GoldTracker.savedVariablesAccount.bank .. "g"))
	GoldTrackerGuiOverviewAllBank:SetColor(colorBalanceDimmed:UnpackRGBA())
end

function GoldTracker.UpdateAllBalance()
	local sum=0
	for i=1, #GoldTracker.savedVariablesAccount.charlist do
		charactername=GoldTracker.savedVariablesAccount.charlist[i];
		GoldTracker.savedVariablesAlt = ZO_SavedVars:New("GoldTrackerSavedVariables", 1, nil, LastResetDefaults, "Default", GetDisplayName(), charactername);
		sum = sum + GoldTracker.savedVariablesAlt.resetBalance + GoldTracker.savedVariablesAlt.income + GoldTracker.savedVariablesAlt.expenses;
	end
	sum = sum + GoldTracker.savedVariablesAccount.bank;
	GoldTrackerGuiOverviewAllBalanceLabel:SetColor(colorTextAll:UnpackRGBA())
	GoldTrackerGuiOverviewAllBalance:SetText(string.format(sum .. "g"))
	GoldTrackerGuiOverviewAllBalance:SetColor(colorBalance:UnpackRGBA())
end

-- This function will create new labels in the overview gui for all alts and populate the info
function GoldTracker.UpdateAllAlts()
	local numchars = #GoldTracker.savedVariablesAccount.charlist
	if (numchars == 1) then
		return
	end
	GoldTrackerGuiOverview:SetDimensions(255,305+numchars*20);
	GoldTrackerGuiOverviewBackdrop:SetDimensions(255,305+numchars*20);
	local mylabel = ""
	local altstatus = ""
	local index = 1
	for i=1, numchars do
		charname = GoldTracker.savedVariablesAccount.charlist[i];
		if (charname ~= GetUnitName("Player")) then
			mylabel = "GoldTrackerGuiOverviewAltLabel"..index
			Alt = wm:CreateControl(mylabel, GoldTrackerGuiOverview, CT_LABEL);
			Alt:SetColor(colorPlayerNameDimmed:UnpackRGBA())
			Alt:SetFont("ZoFontChat")
			Alt:SetWrapMode(TRUNCATE)
			Alt:SetDrawLayer(1)
			Alt:SetAnchor(TOPLEFT, GoldTrackerGuiOverview, TOPLEFT, 8 , 175+20*index)
			Alt:SetDimensions(245, 30)
			Alt:SetScale(1)
			Alt:SetText(GoldTracker.savedVariablesAccount.charlist[i]);
			mylabel = "GoldTrackerGuiOverviewAlt"..index
			Alt = wm:CreateControl(mylabel, GoldTrackerGuiOverview, CT_LABEL);
			Alt:SetColor(colorPlayerNameDimmed:UnpackRGBA())
			Alt:SetFont("ZoFontChat")
			Alt:SetWrapMode(TRUNCATE)
			Alt:SetDrawLayer(1)
			Alt:SetAnchor(TOPLEFT, GoldTrackerGuiOverview, TOPLEFT, 8 , 175+20*index)
			Alt:SetDimensions(245, 30)
			Alt:SetScale(1)
			Alt:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
			GoldTracker.savedVariablesAlt = ZO_SavedVars:New("GoldTrackerSavedVariables", 1, nil, LastResetDefaults, "Default", GetDisplayName(), charname);
			altstatus = GoldTracker.savedVariablesAlt.income + GoldTracker.savedVariablesAlt.expenses
			altstatus = altstatus.."/"..GoldTracker.savedVariablesAlt.resetBalance
			Alt:SetText(altstatus);
			index = index + 1
		end
	end
end

function GoldTracker.OnGuiOverviewMoveStop()
  GoldTracker.savedVariables.left = GoldTrackerGuiOverview:GetLeft()
  GoldTracker.savedVariables.top = GoldTrackerGuiOverview:GetTop()
end

function GoldTracker:RestorePosition()
  local left = self.savedVariables.left
  local top = self.savedVariables.top
 
  GoldTrackerGuiOverview:ClearAnchors()
  GoldTrackerGuiOverview:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end