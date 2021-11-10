AddCSLuaFile("cl_alibi_init.lua")
util.AddNetworkString("ttt2SendRoleAlibi")

hook.Add("TTT2UpdateSubrole", "TTT2CreateAlibi", function(ply, oldSubrole, newSubrole)
    timer.Simple(0.1, function() 
        if (IsValid(ply) and ply:GetSubRoleData().defaultTeam ~= "innocents") then
            local selectablePlys = roleselection.GetSelectablePlayers(player.GetAll())
            local alibiRoleCandidates = table.Copy(roleselection.GetAllSelectableRolesList(#selectablePlys))
            local avoidRoles = {"detective", "banker", "revolutionary", "sheriff", "sniffer", "vigilante", "wrath", "shinigami", "liar", "bodyguard", "cupid", "ghost"}
            local alibiRoles = {}
            local alibiRolesCount = 0
            
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
                        alibiRolesCount = alibiRolesCount + 1
                    end
                end
            end

            local alibiName = alibiRoles[math.random(1, alibiRolesCount)]
            local plyRoleName = ply:GetSubRoleData().name

            if plyRoleName == "defective" then
                alibiName = "detective"
            elseif plyRoleName == "jester" or plyRoleName == "swapper" or plyRoleName == "clown" then
                alibiName = "beggar"
            elseif plyRoleName == "doppelganger" then
                alibiName = "mimic"
            elseif plyRoleName == "beggar" or plyRoleName == "medic" or plyRoleName == "bodyguard" or plyRoleName == "unknown" or plyRoleName == "pirate_captain" or plyRoleName == "none" then
                return
            end

            net.Start("ttt2SendRoleAlibi")
            net.WriteString(alibiName)
            net.Send(ply)
        end
    end)
end)