-- AUTO-PARRY ЧЕРЕЗ КЛАВИШУ F (РАБОТАЕТ НА ТЕЛЕФОНЕ)
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local autoParry = true
local parryRadius = 20

-- Функция эмуляции нажатия клавиши F
local function doParry()
    VirtualInputManager:SendKeyEvent(true, "F", false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, "F", false, game)
end

-- Основной цикл
task.spawn(function()
    while task.wait(0.05) do
        if not autoParry then continue end
        
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        
        local root = char.HumanoidRootPart
        
        -- Ищем мяч (Ball)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name == "Ball" then
                local dist = (v.Position - root.Position).Magnitude
                if dist <= parryRadius then
                    doParry()
                    break
                end
            end
        end
    end
end)

print("AUTO-PARRY РАБОТАЕТ! Клавиша: F (DEFLECT)")
