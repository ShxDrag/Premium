local adm = require(
    game:GetService("ReplicatedStorage")
        :WaitForChild("ClientModules")
        :WaitForChild("Core")
        :WaitForChild("UIManager")
        :WaitForChild("Elements")
        :WaitForChild("AboveCharStack")
)

local dy = adm.destroy

adm.destroy = function(...)
    local result = dy(...)
    _G.CachedJobId = game.JobId
    print(_G.CachedJobId)
    adm.destroy = dy
    return result
end

repeat
    stepAnimate = nil

    for _, v in ipairs(getgc(true)) do
        if typeof(v) == "function" then
            local info = debug.getinfo(v)
            if info and info.name == "stepAnimate" then
                stepAnimate = v
                break
            end
        end
    end

    task.wait()
until stepAnimate

local printed = false
old = hookfunction(stepAnimate, function(dt)
    if not printed then
        printed = true
        _G.CachedJobId = game.JobId
        print(_G.CachedJobId)
    end

    return old(dt)
end)

-- Cache the hashes before loading obfuscated script
_G.CachedHashes = {}
for _, v in pairs(getgc()) do
    if type(v) == "function" and debug.getinfo(v).name == "get_remote_from_cache" then
        local upvalues = debug.getupvalues(v)
        if type(upvalues[1]) == "table" then
            for key, value in pairs(upvalues[1]) do
                _G.CachedHashes[key] = value
            end
            break
        end
    end
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/ShxDrag/Scripty/refs/heads/main/Admz.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ShxDrag/Premium/refs/heads/main/Best.lua"))()
