-- [[ PREMIUM MM2 GUI WITH KEY SYSTEM BY FANTOM ]] --
-- [[ MINI MENU 15% SCREEN & SHERIFF AIM UPDATE ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- БАЗА ДАННЫХ: Ключи
local ValidKeys = {}
for i = 1, 50 do
    local num = tostring(i)
    if i < 10 then num = "0" .. num end 
    ValidKeys["FANTOM-KEY-" .. num] = true
end

local Config = {
    ESP_Murder = false,
    ESP_Sheriff = false,
    ESP_Innocent = false,
    AimBot_Murder = false,   -- АИМ НА МАНЬЯКА (ДЛЯ ШЕРИФА)
    AimBot_Sheriff = false,  -- АИМ НА КОПА (ДЛЯ МАНЬЯКА)
    AimBot_Innocent = false, -- АИМ НА МИРНЫХ (ДЛЯ МАНЬЯКА)
    AutoCollect = false,     -- АВТО-СБОР МОНЕТ
    Aim_Smoothness = 0.15,
    MenuKey = Enum.KeyCode.F
}

if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("FantomMM2_Premium") then
    LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("FantomMM2_Premium"):Destroy()
end

local UI = Instance.new("ScreenGui")
UI.Name = "FantomMM2_Premium"
UI.Parent = LocalPlayer:WaitForChild("PlayerGui")
UI.ResetOnSpawn = false

------------------------------------------------------------------------
-- [ ИНТЕРФЕЙС АВТОРИЗАЦИИ ]
------------------------------------------------------------------------
local KeyWindow = Instance.new("Frame")
KeyWindow.Name = "KeyWindow"
KeyWindow.Size = UDim2.new(0, 300, 0, 220)
KeyWindow.Position = UDim2.new(0.5, -150, 0.5, -110)
KeyWindow.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyWindow.BackgroundTransparency = 0.35
KeyWindow.BorderSizePixel = 0
KeyWindow.Active = true
KeyWindow.Draggable = true
KeyWindow.Parent = UI

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyWindow

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(231, 76, 60)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyWindow

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 35)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "KEY SYSTEM // BY FANTOM"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 13
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyWindow

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 240, 0, 35)
KeyInput.Position = UDim2.new(0.5, -120, 0, 70)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyInput.BackgroundTransparency = 0.35
KeyInput.Text = ""
KeyInput.PlaceholderText = "Вставьте ключ сюда..."
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 90)
KeyInput.Font = Enum.Font.Code
KeyInput.TextSize = 12
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyWindow

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 6)
KeyInputCorner.Parent = KeyInput

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 115)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Ожидание ключа..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Parent = KeyWindow

local CheckBtn = Instance.new("TextButton")
CheckBtn.Size = UDim2.new(0, 240, 0, 35)
CheckBtn.Position = UDim2.new(0.5, -120, 0, 155)
CheckBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CheckBtn.BackgroundTransparency = 0.2
CheckBtn.Text = "ПРОВЕРИТЬ КЛЮЧ"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.TextSize = 11
CheckBtn.Parent = KeyWindow

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 6)
CheckCorner.Parent = CheckBtn

------------------------------------------------------------------------
-- [ КОМПАКТНОЕ ГЛАВНОЕ МЕНЮ (15% ЭКРАНА) ]
------------------------------------------------------------------------
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 260, 0, 340) -- Немного увеличили высоту под кнопки вкладок
Main.Position = UDim2.new(0.1, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BackgroundTransparency = 0.35
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = false
Main.Parent = UI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(231, 76, 60)
MainStroke.Thickness = 2
MainStroke.Parent = Main

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Header.BackgroundTransparency = 0.35
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 8)
HeaderFix.Position = UDim2.new(0, 0, 1, -8)
HeaderFix.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
HeaderFix.BackgroundTransparency = 0.35
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -15, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "FANTOM MM2 // PREMIUM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

------------------------------------------------------------------------
-- [ ПАНЕЛЬ ДЛЯ ВКЛАДОК ]
------------------------------------------------------------------------
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 35)
TabBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TabBar.BackgroundTransparency = 0.35
TabBar.BorderSizePixel = 0
TabBar.Parent = Main

local Tab1Btn = Instance.new("TextButton")
Tab1Btn.Size = UDim2.new(0.5, 0, 1, 0)
Tab1Btn.BackgroundTransparency = 1
Tab1Btn.Text = "ESP & AIM"
Tab1Btn.TextColor3 = Color3.fromRGB(231, 76, 60)
Tab1Btn.Font = Enum.Font.GothamBold
Tab1Btn.TextSize = 10
Tab1Btn.Parent = TabBar

local Tab2Btn = Instance.new("TextButton")
Tab2Btn.Size = UDim2.new(0.5, 0, 1, 0)
Tab2Btn.Position = UDim2.new(0.5, 0, 0, 0)
Tab2Btn.BackgroundTransparency = 1
Tab2Btn.Text = "AUTO COINS"
Tab2Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
Tab2Btn.Font = Enum.Font.GothamBold
Tab2Btn.TextSize = 10
Tab2Btn.Parent = TabBar

-- Скролл-контейнеры для вкладок
local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Name = "ScrollContainer"
ScrollContainer.Size = UDim2.new(1, -12, 1, -75)
ScrollContainer.Position = UDim2.new(0, 6, 0, 70)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 310)
ScrollContainer.ScrollBarThickness = 3
ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(231, 76, 60)
ScrollContainer.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 6)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = ScrollContainer

local ScrollContainer2 = Instance.new("ScrollingFrame")
ScrollContainer2.Name = "ScrollContainer2"
ScrollContainer2.Size = UDim2.new(1, -12, 1, -75)
ScrollContainer2.Position = UDim2.new(0, 6, 0, 70)
ScrollContainer2.BackgroundTransparency = 1
ScrollContainer2.CanvasSize = UDim2.new(0, 0, 0, 200)
ScrollContainer2.ScrollBarThickness = 3
ScrollContainer2.ScrollBarImageColor3 = Color3.fromRGB(231, 76, 60)
ScrollContainer2.Visible = false
ScrollContainer2.Parent = Main

local Layout2 = Instance.new("UIListLayout")
Layout2.Padding = UDim.new(0, 6)
Layout2.SortOrder = Enum.SortOrder.LayoutOrder
Layout2.Parent = ScrollContainer2

-- Переключение вкладок
Tab1Btn.MouseButton1Click:Connect(function()
    ScrollContainer.Visible = true
    ScrollContainer2.Visible = false
    Tab1Btn.TextColor3 = Color3.fromRGB(231, 76, 60)
    Tab2Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    ScrollContainer.Visible = false
    ScrollContainer2.Visible = true
    Tab1Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    Tab2Btn.TextColor3 = Color3.fromRGB(231, 76, 60)
end)

------------------------------------------------------------------------
-- [ КНОПКА ТУГГЛА (КРАСИВАЯ, НАЖИМАЕМАЯ) ]
------------------------------------------------------------------------
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "FantomToggle"
ToggleBtn.Size = UDim2.new(0, 90, 0, 35)
ToggleBtn.Position = UDim2.new(0.5, -45, 0, 15)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
ToggleBtn.BackgroundTransparency = 0.35
ToggleBtn.Text = "FANTOM"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
ToggleBtn.TextStrokeTransparency = 0.8
ToggleBtn.Visible = false 
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = UI

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 18)
ToggleCorner.Parent = ToggleBtn

local ToggleUIGradient = Instance.new("UIGradient")
ToggleUIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(231, 76, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 20, 20))
}
ToggleUIGradient.Rotation = 45
ToggleUIGradient.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleStroke.Thickness = 1.5
ToggleStroke.Transparency = 0.4
ToggleStroke.Parent = ToggleBtn

local IsUnlocked = false
local MenuVisible = true

local function ToggleMenu()
    if not IsUnlocked then return end
    MenuVisible = not MenuVisible
    
    if MenuVisible then
        Main.Visible = true
        MainStroke.Enabled = true
        Header.Visible = true
        TabBar.Visible = true
        if ScrollContainer.Visible == false and ScrollContainer2.Visible == false then
            ScrollContainer.Visible = true
        end
        TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 260, 0, 340)}):Play()
    else
        Header.Visible = false
        TabBar.Visible = false
        ScrollContainer.Visible = false
        ScrollContainer2.Visible = false
        MainStroke.Enabled = false
        local closeTween = TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 260, 0, 0)})
        closeTween:Play()
        closeTween.Completed:Connect(function()
            if not MenuVisible then Main.Visible = false end
        end)
    end
end

ToggleBtn.MouseButton1Click:Connect(ToggleMenu)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Config.MenuKey and IsUnlocked then
        ToggleMenu()
    end
end)

------------------------------------------------------------------------
-- [ ВАЛИДАТОР КЛЮЧЕЙ ]
------------------------------------------------------------------------
local function CleanString(str)
    local noSpaces = str:gsub("%s+", "")
    return noSpaces:gsub("%c", "")
end

local function CheckTheKey()
    if IsUnlocked then return end
    local rawText = KeyInput.Text
    local cleanedKey = CleanString(rawText)
    
    if ValidKeys[cleanedKey] then
        IsUnlocked = true
        KeyInput:ReleaseFocus()
        StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
        StatusLabel.Text = "Ключ принят! Запуск меню..."
        CheckBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        task.wait(0.4)
        KeyWindow:Destroy()
        Main.Visible = true
        ToggleBtn.Visible = true
    end
end

task.spawn(function()
    while not IsUnlocked and task.wait(0.1) do
        if #KeyInput.Text > 0 then CheckTheKey() end
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local guiObjects = LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(input.Position.X, input.Position.Y)
        for _, obj in pairs(guiObjects) do
            if obj == CheckBtn then
                CheckTheKey()
                if not IsUnlocked and #KeyInput.Text > 0 then
                    StatusLabel.TextColor3 = Color3.fromRGB(231, 76, 60)
                    StatusLabel.Text = "Неверный формат или чужой ключ!"
                end
            end
        end
    end
end)

------------------------------------------------------------------------
-- [ УНИВЕРСАЛЬНЫЙ КОНСТРУКТОР КНОПОК ]
------------------------------------------------------------------------
local function AddToggle(name, infoText, parentScroll, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -4, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Frame.BackgroundTransparency = 0.35
    Frame.BorderSizePixel = 0
    Frame.Parent = parentScroll
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 6)
    FrameCorner.Parent = Frame
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    TextLabel.Position = UDim2.new(0, 8, 0, 4)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = name
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 11
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame

    local SubLabel = Instance.new("TextLabel")
    SubLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    SubLabel.Position = UDim2.new(0, 8, 0, 20)
    SubLabel.BackgroundTransparency = 1
    SubLabel.Text = infoText
    SubLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    SubLabel.Font = Enum.Font.Gotham
    SubLabel.TextSize = 9
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubLabel.Parent = Frame
    
    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 42, 0, 22)
    Switch.Position = UDim2.new(1, -50, 0.5, -11)
    Switch.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Switch.BackgroundTransparency = 0.2
    Switch.Text = ""
    Switch.Parent = Frame
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 3, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = Switch
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local state = false
    Switch.Activated:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local targetColor = state and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(40, 40, 50)
        
        TweenService:Create(Circle, TweenInfo.new(0.18), {Position = targetPos}):Play()
        TweenService:Create(Switch, TweenInfo.new(0.18), {BackgroundColor3 = targetColor}):Play()
        
        callback(state)
    end)
end

-- ВКЛАДКА 1: Кнопки ESP и AIM
AddToggle("Подсветка Убийцы", "Маньяк подсвечен красным", ScrollContainer, function(state) Config.ESP_Murder = state end)
AddToggle("Подсветка Шерифа", "Коп подсвечен синим", ScrollContainer, function(state) Config.ESP_Sheriff = state end)
AddToggle("Подсветка Мирных", "Граждане подсвечены белым", ScrollContainer, function(state) Config.ESP_Innocent = state end)
AddToggle("Аимбот на Убийцу", "Авто-наведение на Маньяка (для Шерифа)", ScrollContainer, function(state) Config.AimBot_Murder = state end)
AddToggle("Аимбот на Шерифа", "Авто-наведение на Копа (для Убийцы)", ScrollContainer, function(state) Config.AimBot_Sheriff = state end)
AddToggle("Аимбот на Мирных", "Авто-наведение на Жителей (для Убийцы)", ScrollContainer, function(state) Config.AimBot_Innocent = state end)

-- ВКЛАДКА 2: Кнопка Авто-Сбора Монет
AddToggle("Auto Collection", "Сбор монет телепортом по всей карте", ScrollContainer2, function(state) Config.AutoCollect = state end)

------------------------------------------------------------------------
-- [ СЕРВЕРНАЯ ЛОГИКА И АВТО-СБОР ]
------------------------------------------------------------------------
local function GetPlayerRole(player)
    if not player or not player:FindFirstChild("Backpack") then return "Innocent" end
    local character = player.Character
    if player.Backpack:FindFirstChild("Knife") or (character and character:FindFirstChild("Knife")) then return "Murder" end
    if player.Backpack:FindFirstChild("Gun") or (character and character:FindFirstChild("Gun")) then return "Sheriff" end
    return "Innocent"
end

local function ApplyHighlight(player, color)
    local char = player.Character
    if not char then return end
    local hl = char:FindFirstChild("Fantom_Highlight")
    if not hl then
        hl = Instance.new("Highlight")
        hl.Name = "Fantom_Highlight"
        hl.Parent = char
    end
    hl.FillColor = color
    hl.OutlineColor = Color3.fromRGB(0, 0, 0)
    hl.FillTransparency = 0.4
    hl.OutlineTransparency = 0.1
end

local function CleanHighlight(player)
    if player.Character then
        local hl = player.Character:FindFirstChild("Fantom_Highlight")
        if hl then hl:Destroy() end
    end
end

-- Логический поток для Auto Collect монет
task.spawn(function()
    while true do
        task.wait(0.2)
        if IsUnlocked and Config.AutoCollect then
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                
                if hrp and hum and hum.Health > 0 then
                    -- Поиск контейнера с монетами на карте MM2
                    local coinContainer = workspace:FindFirstChild("Normal") or workspace:FindFirstChild("Coins")
                    if coinContainer then
                        local coinFolder = coinContainer:FindFirstChild("CoinContainer") or coinContainer
                        for _, obj in pairs(coinFolder:GetChildren()) do
                            if Config.AutoCollect and obj:IsA("BasePart") and obj.Name == "Coin_Server" then
                                -- ТП к монете, небольшая задержка, чтобы подобралась
                                hrp.CFrame = obj.CFrame
                                task.wait(0.18)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not IsUnlocked then return end
    
    local CurrentMurderPlayer = nil
    local CurrentSheriffPlayer = nil
    local ClosestInnocent = nil
    local MinDistance = math.huge
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            pcall(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") and p.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                    local role = GetPlayerRole(p)
                    
if role == "Murder" then
                        CurrentMurderPlayer = p
                        if Config.ESP_Murder then ApplyHighlight(p, Color3.fromRGB(231, 76, 60)) else CleanHighlight(p) end
                    elseif role == "Sheriff" then
                        CurrentSheriffPlayer = p
                        if Config.ESP_Sheriff then ApplyHighlight(p, Color3.fromRGB(52, 152, 219)) else CleanHighlight(p) end
                    elseif role == "Innocent" then
                        if Config.ESP_Innocent then ApplyHighlight(p, Color3.fromRGB(241, 242, 246)) else CleanHighlight(p) end
                        
                        local dist = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                        if dist < MinDistance then
                            MinDistance = dist
                            ClosestInnocent = p
                        end
                    end
                else
                    CleanHighlight(p)
                end
            end)
        end
    end
    
    -- Умный Аимбот
    local myRole = GetPlayerRole(LocalPlayer)
    local targetChar = nil
    
    if myRole == "Sheriff" or myRole == "Innocent" then
        if Config.AimBot_Murder and CurrentMurderPlayer then
            targetChar = CurrentMurderPlayer.Character
        end
    elseif myRole == "Murder" then
        if Config.AimBot_Sheriff and CurrentSheriffPlayer then
            targetChar = CurrentSheriffPlayer.Character
        elseif Config.AimBot_Innocent and ClosestInnocent then
            targetChar = ClosestInnocent.Character
        end
    end
    
    if targetChar and targetChar:FindFirstChild("Head") then
        local targetHead = targetChar.Head
        local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            local targetCFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Config.Aim_Smoothness)
        end
    end
end)
