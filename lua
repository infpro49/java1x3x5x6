local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "java1x3x5x6 reborn gui v2"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui


local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 500)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui


local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame


local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Image = "rbxassetid://891352111"
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.Position = UDim2.new(0, 0, 0, 0)
backgroundImage.BackgroundTransparency = 0.7
backgroundImage.BorderSizePixel = 0
backgroundImage.Parent = mainFrame


mainFrame.Active = true
mainFrame.Draggable = true


local title = Instance.new("TextLabel")
title.Text = "java1x3x5x6 gui v2 by er1r"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.FredokaOne
title.TextScaled = true
title.TextColor3 = Color3.new(1, 0, 0)
title.Parent = mainFrame

task.spawn(function()
	local colors = {Color3.new(1, 0, 0), Color3.new(1, 1, 1)}
	local idx = 1
	while true do
		title.TextColor3 = colors[idx]
		idx = idx % #colors + 1
		task.wait(0.5)
	end
end)


local char = player.Character or player.CharacterAdded:Wait()
local tool
for _,v in pairs(player:GetDescendants()) do
	if v.Name == "SyncAPI" then
		tool = v.Parent
		break
	end
end
if not tool then
	for _,v in pairs(game.ReplicatedStorage:GetDescendants()) do
		if v.Name == "SyncAPI" then
			tool = v.Parent
			break
		end
	end
end
if not tool then
	warn("this won't effect you it's for the script to work")
	return
end

local remote = tool.SyncAPI.ServerEndpoint
local function _(args)
	remote:InvokeServer(unpack(args))
end


function SetLocked(part, boolean)
	_( { "SetLocked", { part }, boolean } )
end

function SpawnDecal(part, side)
	_( { "CreateTextures", { { Part = part, Face = side, TextureType = "Decal" } } } )
end

function AddDecal(part, asset, side)
	_( { "SyncTexture", { { Part = part, Face = side, TextureType = "Decal", Texture = "rbxassetid://" .. asset } } } )
end

function CreatePart(cf, parent)
	_( { "CreatePart", "Normal", cf, parent } )
end

function SetName(part, name)
	_( { "SetName", { part }, name } )
end

function AddMesh(part)
	_( { "CreateMeshes", { { Part = part } } } )
end

function SetMesh(part, meshid)
	_( { "SyncMesh", { { Part = part, MeshId = "rbxassetid://" .. meshid } } } )
end

function SetTexture(part, texid)
	_( { "SyncMesh", { { Part = part, TextureId = "rbxassetid://" .. texid } } } )
end

function MeshResize(part, size)
	_( { "SyncMesh", { { Part = part, Scale = size } } } )
end


local function skybox(id)
	local hrp = char:WaitForChild("HumanoidRootPart")
	local x, y, z = math.floor(hrp.Position.X), math.floor(hrp.Position.Y), math.floor(hrp.Position.Z)
	CreatePart(CFrame.new(x, y + 6, z), workspace)
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and math.floor(v.Position.X) == x and math.floor(v.Position.Z) == z then
			SetName(v, "Sky")
			AddMesh(v)
			SetMesh(v, "111891702759441")
			SetTexture(v, id)
			MeshResize(v, Vector3.new(99999, 99999, 99999))
			SetLocked(v, true)
		end
	end
end


local function decalSpam(id)
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			spawn(function()
				SetLocked(v, false)
				for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
					SpawnDecal(v, face)
					AddDecal(v, id, face)
				end
			end)
		end
	end
end


local function makeButton(name, yPos, callback)
	local button = Instance.new("TextButton")
	button.Text = name
	button.Size = UDim2.new(0.9, 0, 0, 35)
	button.Position = UDim2.new(0.05, 0, 0, yPos)
	button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.FredokaOne
	button.TextScaled = true
	button.Parent = mainFrame
	button.MouseButton1Click:Connect(callback)

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button
end


makeButton("decal spam", 50, function()
	decalSpam("891352111")
end)

makeButton("skybox", 95, function()
	skybox("891352111")
end)

local RequestCommandSilent = game.ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent

makeButton("theme", 140, function()
	RequestCommandSilent:InvokeServer(";music 72466949466030")
	RequestCommandSilent:InvokeServer(";pitch 0.25")
	RequestCommandSilent:InvokeServer(";volume inf")
end)

makeButton("disco", 185, function()
	RequestCommandSilent:InvokeServer(";disco")
end)

makeButton("fire all", 230, function()
	RequestCommandSilent:InvokeServer(";fire all")
end)

makeButton("name all", 275, function()
	RequestCommandSilent:InvokeServer(";name all java was here")
end)

makeButton("loopkill all", 320, function()
	RequestCommandSilent:InvokeServer(";loopkill all")
end)

makeButton("chat all", 365, function()
	RequestCommandSilent:InvokeServer(";say all JAVA1X3X5X6 RETURNED")
end)

makeButton("billboard gui", 410, function()
	RequestCommandSilent:InvokeServer(";titler me 1x3x5x6")
end)

makeButton("char All", 455, function()
	RequestCommandSilent:InvokeServer(";char all 151784900")
end)

makeButton("kill all", 455, function()
	RequestCommandSilent:InvokeServer(";kill all")
end)

makeButton("creepy fog", 455, function()
	RequestCommandSilent:InvokeServer(";fogcolor black")
   RequestCommandSilent:InvokeServer(";fog")   
end)

makeButton("message", 455, function()
	RequestCommandSilent:InvokeServer(";sm java hacked this")
end)

makeButton("server hint", 455, function()
	RequestCommandSilent:InvokeServer(";sh java hacked this")
end)
