AddCSLuaFile("cl_alibi_init.lua")
util.AddNetworkString("ttt2SendRoleAlibi")

hook.Add("TTTBeginRound", "TTT2RequestRoleAlibiBeginRound", function()
    timer.Create("alibi", 1, 1, function()

        local selectablePlys = roleselection.GetSelectablePlayers(player.GetAll())
        local alibiRoleCandidates = table.Copy(roleselection.GetAllSelectableRolesList(#selectablePlys))
        local alibiRoles = {}
        local count = 0
        local avoidRoles = {"detective", "banker", "revolutionary", "sheriff", "sniffer", "vigilante", "wrath", "shinigami", "liar", "bodyguard", "cupid"}
        
        if alibiRoleCandidates == nil then return end

        for k in pairs(alibiRoleCandidates) do
            local tempRole = roles.GetByIndex(k) 
            if tempRole.defaultTeam == "innocents" then
                local allow = true
                for j in pairs(avoidRoles) do
                    if tempRole.name == avoidRoles[j] then
                        allow = false
                        break
                    end
                end
                if allow then
                    table.insert(alibiRoles, tempRole.name)
                    count = count + 1
                end
            end
        end

        net.Start("ttt2SendRoleAlibi")
        for _,ply in ipairs(player:GetAll()) do
            if (IsValid(ply) and ply:GetSubRoleData().defaultTeam ~= "innocents") then
                local alibiName = alibiRoles[math.random(1, count)]
                local plyRoleName = ply:GetSubRoleData().name

                if plyRoleName == "defective" then
                    alibiName = "detective"
                elseif plyRoleName == "jester" or plyRoleName == "swapper" or plyRoleName == "clown" then
                    alibiName = "beggar"
                elseif plyRoleName == "doppelganger" then
                    alibiName = "mimic"
                elseif plyRoleName == "beggar" or plyRoleName == "medic" or plyRoleName == "bodyguard" or plyRoleName == "unknown" or plyRoleName == "pirate_captain" or plyRoleName == "none" then
                    break
                end

                net.WriteString(alibiName)
                net.Send(ply)
            end
        end
    end)
end)