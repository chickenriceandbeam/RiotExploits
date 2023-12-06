-- Made By Riotscripter!

if not getgenv().Ignore then
    getgenv().Ignore = {} -- Add Instances to this table to ignore them (e.g. getgenv().Ignore = {workspace.Map, workspace.Map2})
end
if not getgenv().WaitPerAmount then
    getgenv().WaitPerAmount = 500 -- Set Higher or Lower depending on your computer's performance
end
if getgenv().SendNotifications == nil then
    getgenv().SendNotifications = true -- Set to false if you don't want notifications
end
if getgenv().ConsoleLogs == nil then
    getgenv().ConsoleLogs = false -- Set to true if you want console logs (mainly for debugging)
end



if not game:IsLoaded() then
    repeat
        task.wait()
    until game:IsLoaded()
end
if not getgenv().Settings then
    getgenv().Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true,
            ["Ignore Tools"] = true
        },
        Meshes = {
            NoMesh = false,
            NoTexture = false,
            Destroy = false
        },
        Images = {
            Invisible = true,
            Destroy = false
        },
        Explosions = {
            Smaller = true,
            Invisible = false, -- Not recommended for PVP games
            Destroy = false -- Not recommended for PVP games
        },
        Particles = {
            Invisible = true,
            Destroy = false
        },
        TextLabels = {
            LowerQuality = false,
            Invisible = false,
            Destroy = false
        },
        MeshParts = {
            LowerQuality = true,
            Invisible = false,
            NoTexture = false,
            NoMesh = false,
            Destroy = false
        },
        Other = {
            ["FPS Cap"] = 240, -- Set this true to uncap FPS
            ["No Camera Effects"] = true,
            ["No Clothes"] = true,
            ["Low Water Graphics"] = true,
            ["No Shadows"] = true,
            ["Low Rendering"] = true,
            ["Low Quality Parts"] = true,
            ["Low Quality Models"] = true,
            ["Reset Materials"] = true,
            ["Lower Quality MeshParts"] = true
        }
    }
end
local Players, Lighting, StarterGui, MaterialService = game:GetService("Players"), game:GetService("Lighting"), game:GetService("StarterGui"), game:GetService("MaterialService")
local ME, CanBeEnabled = Players.LocalPlayer, {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}
local function PartOfCharacter(Instance)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= ME and v.Character and Instance:IsDescendantOf(v.Character) then
            return true
        end
    end
    return false
end
local function DescendantOfIgnore(Instance)
    for _, v in pairs(getgenv().Ignore) do
        if Instance:IsDescendantOf(v) then
            return true
        end
    end
    return false
end
local function CheckIfBad(Instance)
    if not Instance:IsDescendantOf(Players) and (getgenv().Settings.Players["Ignore Others"] and not PartOfCharacter(Instance) or not getgenv().Settings.Players["Ignore Others"]) and (getgenv().Settings.Players["Ignore Me"] and ME.Character and not Instance:IsDescendantOf(ME.Character) or not getgenv().Settings.Players["Ignore Me"]) and (getgenv().Settings.Players["Ignore Tools"] and not Instance:IsA("BackpackItem") and not Instance:FindFirstAncestorWhichIsA("BackpackItem") or not getgenv().Settings.Players["Ignore Tools"])--[[not PartOfCharacter(Instance)]] and (getgenv().Ignore and not table.find(getgenv().Ignore, Instance) and not DescendantOfIgnore(Instance) or (not getgenv().Ignore or type(getgenv().Ignore) ~= "table" or #getgenv().Ignore <= 0)) then
        if Instance:IsA("DataModelMesh") then
            if getgenv().Settings.Meshes.NoMesh and Instance:IsA("SpecialMesh") then
                Instance.MeshId = ""
            end
            if getgenv().Settings.Meshes.NoTexture and Instance:IsA("SpecialMesh") then
                Instance.TextureId = ""
            end
            if getgenv().Settings.Meshes.Destroy or getgenv().Settings["No Meshes"] then
                Instance:Destroy()
            end
        elseif Instance:IsA("FaceInstance") then
            if getgenv().Settings.Images.Invisible then
                Instance.Transparency = 1
                Instance.Shiny = 1
            end
            if getgenv().Settings.Images.LowDetail then
                Instance.Shiny = 1
            end
            if getgenv().Settings.Images.Destroy then
                Instance:Destroy()
            end
        elseif Instance:IsA("ShirtGraphic") then
            if getgenv().Settings.Images.Invisible then
                Instance.Graphic = ""
            end
            if getgenv().Settings.Images.Destroy then
                Instance:Destroy()
            end
        elseif table.find(CanBeEnabled, Instance.ClassName) then
            if getgenv().Settings["Invisible Particles"] or getgenv().Settings["No Particles"] or (getgenv().Settings.Other and getgenv().Settings.Other["Invisible Particles"]) or (getgenv().Settings.Particles and getgenv().Settings.Particles.Invisible) then
                Instance.Enabled = false
            end
            if (getgenv().Settings.Other and getgenv().Settings.Other["No Particles"]) or (getgenv().Settings.Particles and getgenv().Settings.Particles.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("PostEffect") and (getgenv().Settings["No Camera Effects"] or (getgenv().Settings.Other and getgenv().Settings.Other["No Camera Effects"])) then
            Instance.Enabled = false
        elseif Instance:IsA("Explosion") then
            if getgenv().Settings["Smaller Explosions"] or (getgenv().Settings.Other and getgenv().Settings.Other["Smaller Explosions"]) or (getgenv().Settings.Explosions and getgenv().Settings.Explosions.Smaller) then
                Instance.BlastPressure = 1
                Instance.BlastRadius = 1
            end
            if getgenv().Settings["Invisible Explosions"] or (getgenv().Settings.Other and getgenv().Settings.Other["Invisible Explosions"]) or (getgenv().Settings.Explosions and getgenv().Settings.Explosions.Invisible) then
                Instance.BlastPressure = 1
                Instance.BlastRadius = 1
                Instance.Visible = false
            end
            if getgenv().Settings["No Explosions"] or (getgenv().Settings.Other and getgenv().Settings.Other["No Explosions"]) or (getgenv().Settings.Explosions and getgenv().Settings.Explosions.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("Clothing") or Instance:IsA("SurfaceAppearance") or Instance:IsA("BaseWrap") then
            if getgenv().Settings["No Clothes"] or (getgenv().Settings.Other and getgenv().Settings.Other["No Clothes"]) then
                Instance:Destroy()
            end
        elseif Instance:IsA("BasePart") and not Instance:IsA("MeshPart") then
            if getgenv().Settings["Low Quality Parts"] or (getgenv().Settings.Other and getgenv().Settings.Other["Low Quality Parts"]) then
                Instance.Material = Enum.Material.Plastic
                Instance.Reflectance = 0
            end
        elseif Instance:IsA("TextLabel") and Instance:IsDescendantOf(workspace) then
            if getgenv().Settings["Lower Quality TextLabels"] or (getgenv().Settings.Other and getgenv().Settings.Other["Lower Quality TextLabels"]) or (getgenv().Settings.TextLabels and getgenv().Settings.TextLabels.LowerQuality) then
                Instance.Font = Enum.Font.SourceSans
                Instance.TextScaled = false
                Instance.RichText = false
                Instance.TextSize = 14
            end
            if getgenv().Settings["Invisible TextLabels"] or (getgenv().Settings.Other and getgenv().Settings.Other["Invisible TextLabels"]) or (getgenv().Settings.TextLabels and getgenv().Settings.TextLabels.Invisible) then
                Instance.Visible = false
            end
            if getgenv().Settings["No TextLabels"] or (getgenv().Settings.Other and getgenv().Settings.Other["No TextLabels"]) or (getgenv().Settings.TextLabels and getgenv().Settings.TextLabels.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("Model") then
            if getgenv().Settings["Low Quality Models"] or (getgenv().Settings.Other and getgenv().Settings.Other["Low Quality Models"]) then
                Instance.LevelOfDetail = 1
            end
        elseif Instance:IsA("MeshPart") then
            if getgenv().Settings["Low Quality MeshParts"] or (getgenv().Settings.Other and getgenv().Settings.Other["Low Quality MeshParts"]) or (getgenv().Settings.MeshParts and getgenv().Settings.MeshParts.LowerQuality) then
                Instance.RenderFidelity = 2
                Instance.Reflectance = 0
                Instance.Material = Enum.Material.Plastic
            end
            if getgenv().Settings["Invisible MeshParts"] or (getgenv().Settings.Other and getgenv().Settings.Other["Invisible MeshParts"]) or (getgenv().Settings.MeshParts and getgenv().Settings.MeshParts.Invisible) then
                Instance.Transparency = 1
                Instance.RenderFidelity = 2
                Instance.Reflectance = 0
                Instance.Material = Enum.Material.Plastic
            end
            if getgenv().Settings.MeshParts and getgenv().Settings.MeshParts.NoTexture then
                Instance.TextureID = ""
            end
            if getgenv().Settings.MeshParts and getgenv().Settings.MeshParts.NoMesh then
                Instance.MeshId = ""
            end
            if getgenv().Settings["No MeshParts"] or (getgenv().Settings.Other and getgenv().Settings.Other["No MeshParts"]) or (getgenv().Settings.MeshParts and getgenv().Settings.MeshParts.Destroy) then
                Instance:Destroy()
            end
        end
    end
end
if getgenv().SendNotifications then
    StarterGui:SetCore("SendNotification", {
        Title = "Made By Riotscripter!",
        Text = "Loading FPS Booster...",
        Duration = math.huge,
        Button1 = "Okay"
    })
end
coroutine.wrap(pcall)(function()
    if (getgenv().Settings["Low Water Graphics"] or (getgenv().Settings.Other and getgenv().Settings.Other["Low Water Graphics"])) then
        if not workspace:FindFirstChildOfClass("Terrain") then
            repeat
                task.wait()
            until workspace:FindFirstChildOfClass("Terrain")
        end
        workspace:FindFirstChildOfClass("Terrain").WaterWaveSize = 0
        workspace:FindFirstChildOfClass("Terrain").WaterWaveSpeed = 0
        workspace:FindFirstChildOfClass("Terrain").WaterReflectance = 0
        workspace:FindFirstChildOfClass("Terrain").WaterTransparency = 0
        if sethiddenproperty then
            sethiddenproperty(workspace:FindFirstChildOfClass("Terrain"), "Decoration", false)
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Made By Riotscripter!",
                Text = "Your exploit does not support sethiddenproperty, please use a different exploit.",
                Duration = 5,
                Button1 = "Okay"
            })
            warn("Your exploit does not support sethiddenproperty, please use a different exploit.")
        end
        if getgenv().SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "Made By Riotscripter!",
                Text = "Low Water Graphics Enabled",
                Duration = 5,
                Button1 = "Okay"
            })
        end
        if getgenv().ConsoleLogs then
            warn("Low Water Graphics Enabled")
        end
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().Settings["No Shadows"] or (getgenv().Settings.Other and getgenv().Settings.Other["No Shadows"]) then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.ShadowSoftness = 0
        if sethiddenproperty then
            sethiddenproperty(Lighting, "Technology", 2)
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Made By Riotscripter!",
                Text = "Your exploit does not support sethiddenproperty, please use a different exploit.",
                Duration = 5,
                Button1 = "Okay"
            })
            warn("Your exploit does not support sethiddenproperty, please use a different exploit.")
        end
        if getgenv().SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "Made By Riotscripter!",
                Text = "No Shadows Enabled",
                Duration = 5,
                Button1 = "Okay"
            })
        end
        if getgenv().ConsoleLogs then
            warn("No Shadows Enabled")
        end
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().Settings["Low Rendering"] or (getgenv().Settings.Other and getgenv().Settings.Other["Low Rendering"]) then
        settings().Rendering.QualityLevel = 1
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        if getgenv().SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "Made By Riotscripter!",
                Text = "Low Rendering Enabled",
                Duration = 5,
                Button1 = "Okay"
            })
        end
        if getgenv().ConsoleLogs then
            warn("Low Rendering Enabled")
        end
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().Settings["Reset Materials"] or (getgenv().Settings.Other and getgenv().Settings.Other["Reset Materials"]) then
        for _, v in pairs(MaterialService:GetChildren()) do
            v:Destroy()
        end
        MaterialService.Use2022Materials = false
        if getgenv().SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "Made By Riotscripter!",
                Text = "Reset Materials Enabled",
                Duration = 5,
                Button1 = "Okay"
            })
        end
        if getgenv().ConsoleLogs then
            warn("Reset Materials Enabled")
        end
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().Settings["FPS Cap"] or (getgenv().Settings.Other and getgenv().Settings.Other["FPS Cap"]) then
        if setfpscap then
            if type(getgenv().Settings["FPS Cap"] or (getgenv().Settings.Other and getgenv().Settings.Other["FPS Cap"])) == "string" or type(getgenv().Settings["FPS Cap"] or (getgenv().Settings.Other and getgenv().Settings.Other["FPS Cap"])) == "number" then
                setfpscap(tonumber(getgenv().Settings["FPS Cap"] or (getgenv().Settings.Other and getgenv().Settings.Other["FPS Cap"])))
                if getgenv().SendNotifications then
                    StarterGui:SetCore("SendNotification", {
                        Title = "Made By Riotscripter!",
                        Text = "FPS Capped to " .. tostring(getgenv().Settings["FPS Cap"] or (getgenv().Settings.Other and getgenv().Settings.Other["FPS Cap"])),
                        Duration = 5,
                        Button1 = "Okay"
                    })
                end
                if getgenv().ConsoleLogs then
                    warn("FPS Capped to " .. tostring(getgenv().Settings["FPS Cap"] or (getgenv().Settings.Other and getgenv().Settings.Other["FPS Cap"])))
                end
            elseif getgenv().Settings["FPS Cap"] or (getgenv().Settings.Other and getgenv().Settings.Other["FPS Cap"]) == true then
                setfpscap(1e6)
                if getgenv().SendNotifications then
                    StarterGui:SetCore("SendNotification", {
                        Title = "Made By Riotscripter!",
                        Text = "FPS Uncapped",
                        Duration = 5,
                        Button1 = "Okay"
                    })
                end
                if getgenv().ConsoleLogs then
                    warn("FPS Uncapped")
                end
            end
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Made By Riotscripter!",
                Text = "FPS Cap Failed",
                Duration = math.huge,
                Button1 = "Okay"
            })
            warn("FPS Cap Failed")
        end
    end
end)
game.DescendantAdded:Connect(function(value)
    wait(getgenv().LoadedWait or 1)
    CheckIfBad(value)
end)
local Descendants = game:GetDescendants()
local StartNumber = getgenv().WaitPerAmount or 500
local WaitNumber = getgenv().WaitPerAmount or 500
if getgenv().SendNotifications then
    StarterGui:SetCore("SendNotification", {
        Title = "Made By Riotscripter!",
        Text = "Checking " .. #Descendants .. " Instances...",
        Duration = 15,
        Button1 = "Okay"
    })
end
if getgenv().ConsoleLogs then
    warn("Checking " .. #Descendants .. " Instances...")
end
for _, v in pairs(Descendants) do
    CheckIfBad(v)
    if i == WaitNumber then
        task.wait()
        if getgenv().ConsoleLogs then
            print("Loaded " .. i .. "/" .. #Descendants)
        end
        WaitNumber = WaitNumber + StartNumber
    end
end
StarterGui:SetCore("SendNotification", {
    Title = "Made By Riotscripter!",
    Text = "FPS Booster Loaded!",
    Duration = math.huge,
    Button1 = "Okay"
})
warn("FPS Booster Loaded!")
--game.DescendantAdded:Connect(CheckIfBad)
--[[game.DescendantAdded:Connect(function(value)
    CheckIfBad(value)
end);]]
