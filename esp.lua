local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = game:GetService("Workspace").CurrentCamera
local UserInputService = game:GetService("UserInputService")
local TestService = game:GetService("TestService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

_G.BoxesVisible = false
_G.LineColor = Color3.fromRGB(13, 105, 172)  
_G.LineThickness = 2  
_G.LineTransparency = 0.9
_G.SizeIncrease = 1
_G.FromMouse = false
_G.FromCenter = false
_G.FromBottom = true
_G.TracersVisible = false  
_G.TracerColor = Color3.fromRGB(13, 105, 172) 
_G.TracerThickness = 1  
_G.TracerTransparency = 0.7
_G.ESPVisible = false
_G.TextColor = Color3.fromRGB(13, 105, 172)   
_G.TextSize = 25
_G.Center = true  
_G.Outline = false
_G.OutlineColor = Color3.fromRGB(163, 162, 165)   
_G.TextTransparency = 1  
_G.TextFont = Drawing.Fonts.UI  

local function CreateBoxes()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= Players.LocalPlayer.Name then
            local TopLeftLine = Drawing.new("Line")
            local TopRightLine = Drawing.new("Line")
            local BottomLeftLine = Drawing.new("Line")
            local BottomRightLine = Drawing.new("Line")

            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then 
                    TopLeftLine.Thickness = _G.LineThickness
                    TopLeftLine.Transparency = _G.LineTransparency
                    TopLeftLine.Color = _G.LineColor
                    
                    TopRightLine.Thickness = _G.LineThickness
                    TopRightLine.Transparency = _G.LineTransparency
                    TopRightLine.Color = _G.LineColor

                    BottomLeftLine.Thickness = _G.LineThickness
                    BottomLeftLine.Transparency = _G.LineTransparency
                    BottomLeftLine.Color = _G.LineColor

                    BottomRightLine.Thickness = _G.LineThickness
                    BottomRightLine.Transparency = _G.LineTransparency
                    BottomRightLine.Color = _G.LineColor
                    
                    local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * _G.SizeIncrease

                    local TopLeftPosition, TopLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                    local TopRightPosition, TopRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                    local BottomLeftPosition, BottomLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
                    local BottomRightPosition, BottomRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)

                    if TopLeftVisible == true then
                        TopLeftLine.From = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                        TopLeftLine.To = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                TopLeftLine.Visible = _G.BoxesVisible
                            else
                                TopLeftLine.Visible = false
                            end
                        else
                            TopLeftLine.Visible = _G.BoxesVisible
                        end
                    else
                        TopLeftLine.Visible = false
                    end

                    if TopRightVisible == true and _G.BoxesVisible == true then
                        TopRightLine.From = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                        TopRightLine.To = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                TopRightLine.Visible = _G.BoxesVisible
                            else
                                TopRightLine.Visible = false
                            end
                        else
                            TopRightLine.Visible = _G.BoxesVisible
                        end
                    else
                        TopRightLine.Visible = false
                    end

                    if BottomLeftVisible == true and _G.BoxesVisible == true then
                        BottomLeftLine.From = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                        BottomLeftLine.To = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                BottomLeftLine.Visible = _G.BoxesVisible
                            else
                                BottomLeftLine.Visible = false
                            end
                        else
                            BottomLeftLine.Visible = _G.BoxesVisible
                        end
                    else
                        BottomLeftLine.Visible = false
                    end

                    if BottomRightVisible == true and _G.BoxesVisible == true then
                        BottomRightLine.From = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                        BottomRightLine.To = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                BottomRightLine.Visible = _G.BoxesVisible
                            else
                                BottomRightLine.Visible = false
                            end
                        else
                            BottomRightLine.Visible = _G.BoxesVisible
                        end
                    else
                        BottomRightLine.Visible = false
                    end
                else
                    TopRightLine.Visible = false
                    TopLeftLine.Visible = false
                    BottomLeftLine.Visible = false
                    BottomRightLine.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                TopRightLine.Visible = false
                TopLeftLine.Visible = false
                BottomLeftLine.Visible = false
                BottomRightLine.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= Players.LocalPlayer.Name then
                local TopLeftLine = Drawing.new("Line")
                local TopRightLine = Drawing.new("Line")
                local BottomLeftLine = Drawing.new("Line")
                local BottomRightLine = Drawing.new("Line")
    
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then 
                        TopLeftLine.Thickness = _G.LineThickness
                        TopLeftLine.Transparency = _G.LineTransparency
                        TopLeftLine.Color = _G.LineColor
    
                        TopRightLine.Thickness = _G.LineThickness
                        TopRightLine.Transparency = _G.LineTransparency
                        TopRightLine.Color = _G.LineColor
    
                        BottomLeftLine.Thickness = _G.LineThickness
                        BottomLeftLine.Transparency = _G.LineTransparency
                        BottomLeftLine.Color = _G.LineColor
    
                        BottomRightLine.Thickness = _G.LineThickness
                        BottomRightLine.Transparency = _G.LineTransparency
                        BottomRightLine.Color = _G.LineColor
                        
                        local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * _G.SizeIncrease
    
                        local TopLeftPosition, TopLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                        local TopRightPosition, TopRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                        local BottomLeftPosition, BottomLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
                        local BottomRightPosition, BottomRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
    
                        if TopLeftVisible == true then
                            TopLeftLine.From = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                            TopLeftLine.To = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    TopLeftLine.Visible = _G.BoxesVisible
                                else
                                    TopLeftLine.Visible = false
                                end
                            else
                                TopLeftLine.Visible = _G.BoxesVisible
                            end
                        else
                            TopLeftLine.Visible = false
                        end
    
                        if TopRightVisible == true and _G.BoxesVisible == true then
                            TopRightLine.From = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                            TopRightLine.To = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    TopRightLine.Visible = _G.BoxesVisible
                                else
                                    TopRightLine.Visible = false
                                end
                            else
                                TopRightLine.Visible = _G.BoxesVisible
                            end
                        else
                            TopRightLine.Visible = false
                        end
    
                        if BottomLeftVisible == true and _G.BoxesVisible == true then
                            BottomLeftLine.From = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                            BottomLeftLine.To = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    BottomLeftLine.Visible = _G.BoxesVisible
                                else
                                    BottomLeftLine.Visible = false
                                end
                            else
                                BottomLeftLine.Visible = _G.BoxesVisible
                            end
                        else
                            BottomLeftLine.Visible = false
                        end
    
                        if BottomRightVisible == true and _G.BoxesVisible == true then
                            BottomRightLine.From = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                            BottomRightLine.To = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    BottomRightLine.Visible = _G.BoxesVisible
                                else
                                    BottomRightLine.Visible = false
                                end
                            else
                                BottomRightLine.Visible = _G.BoxesVisible
                            end
                        else
                            BottomRightLine.Visible = false
                        end
                    else
                        TopRightLine.Visible = false
                        TopLeftLine.Visible = false
                        BottomLeftLine.Visible = false
                        BottomRightLine.Visible = false
                    end
                end)
    
                Players.PlayerRemoving:Connect(function()
                    TopRightLine.Visible = false
                    TopLeftLine.Visible = false
                    BottomLeftLine.Visible = false
                    BottomRightLine.Visible = false
                end)
            end
        end)
    end)
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.DisableKey and Typing == false then
        _G.BoxesVisible = not _G.BoxesVisible
        
        end
end)

local function CreateTracers()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= game.Players.LocalPlayer.Name then
            local TracerLine = Drawing.new("Line")
    
            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                    local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
                    local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
                    
                    TracerLine.Thickness = _G.TracerThickness
                    TracerLine.Transparency = _G.TracerTransparency
                    TracerLine.Color = _G.TracerColor

                    if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
                        TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    end

                    if OnScreen == true  then
                        TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                TracerLine.Visible = _G.TracersVisible
                            else
                                TracerLine.Visible = false
                            end
                        else
                            TracerLine.Visible = _G.TracersVisible
                        end
                    else
                        TracerLine.Visible = false
                    end
                else
                    TracerLine.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                TracerLine.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= game.Players.LocalPlayer.Name then
                local TracerLine = Drawing.new("Line")
        
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
                        local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
                        
                        TracerLine.Thickness = _G.TracerThickness
                        TracerLine.Transparency = _G.TracerTransparency
                        TracerLine.Color = _G.TracerColor

                        if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
                            TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                        elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        end

                        if OnScreen == true  then
                            TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    TracerLine.Visible = _G.TracersVisible
                                else
                                    TracerLine.Visible = false
                                end
                            else
                                TracerLine.Visible = _G.TracersVisible
                            end
                        else
                            TracerLine.Visible = false
                        end
                    else
                        TracerLine.Visible = false
                    end
                end)

                Players.PlayerRemoving:Connect(function()
                    TracerLine.Visible = false
                end)
            end
        end)
    end)
end
local function CreateESP()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= Players.LocalPlayer.Name then
            local ESP = Drawing.new("Text")

            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                    local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)

                    ESP.Size = _G.TextSize
                    ESP.Center = _G.Center
                    ESP.Outline = _G.Outline
                    ESP.OutlineColor = _G.OutlineColor
                    ESP.Color = _G.TextColor
                    ESP.Transparency = _G.TextTransparency
                    ESP.Font = _G.TextFont

                    if OnScreen == true then
                        local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                        local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                        local Dist = (Part1 - Part2).Magnitude
                        ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                        ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                ESP.Visible = _G.ESPVisible
                            else
                                ESP.Visible = false
                            end
                        else
                            ESP.Visible = _G.ESPVisible
                        end
                    else
                        ESP.Visible = false
                    end
                else
                    ESP.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                ESP.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= Players.LocalPlayer.Name then 
                local ESP = Drawing.new("Text")
    
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
    
                        ESP.Size = _G.TextSize
                        ESP.Center = _G.Center
                        ESP.Outline = _G.Outline
                        ESP.OutlineColor = _G.OutlineColor
                        ESP.Color = _G.TextColor
                        ESP.Transparency = _G.TextTransparency
    
                        if OnScreen == true then
                            local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                        local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                            local Dist = (Part1 - Part2).Magnitude
                            ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                            ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    ESP.Visible = _G.ESPVisible
                                else
                                    ESP.Visible = false
                                end
                            else
                                ESP.Visible = _G.ESPVisible
                            end
                        else
                            ESP.Visible = false
                        end
                    else
                        ESP.Visible = false
                    end
                end)
    
                Players.PlayerRemoving:Connect(function()
                    ESP.Visible = false
                end)
            end
        end)
    end)
end

local Success, Errored = pcall(function()
    CreateBoxes()
    CreateTracers()
    CreateESP()
end)
