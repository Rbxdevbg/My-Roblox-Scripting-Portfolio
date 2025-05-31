print("There is the speed collector!")


local SpeedCollector = game.Workspace:WaitForChild("Speed collector")
SpeedCollector.Anchored = true
SpeedCollector.Locked = true

local speedValue = 0

-- Charge the collector over time
task.spawn(function()
	while true do
		speedValue += 1
		-- Optional: Print to debug
		print("Speed stored: " .. speedValue)
		task.wait(1)
	end
end)

-- Give speed to player on touch
SpeedCollector.Touched:Connect(function(hit)
	local character = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	if player then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			local leaderstats = player:FindFirstChild("leaderstats")
			local Speed = leaderstats and leaderstats:FindFirstChild("Speed")
			if Speed then
				Speed.Value += speedValue
				humanoid.WalkSpeed += speedValue
				print(player.Name .. " gained +" .. speedValue .. " speed!")
				speedValue = 0 -- Reset collector
			end
		end
	end
end)

-- PlayerAdded handles leaderstats
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local Speed = Instance.new("IntValue")
	Speed.Name = "Speed"
	Speed.Value = 0
	Speed.Parent = leaderstats
end)
