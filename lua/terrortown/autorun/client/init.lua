/*AddCSLuaFile("cl_init.lua")

util.AddNetworkString("ttt2SendRoleAlibi")

hook.Add("TTTBeginRound", "TTT2RequestRoleAlibiBeginRound", function()
    for _,ply in ipairs(player:GetAll()) do
        if IsValid(ply) then
            net.Start("ttt2SendRoleAlibi")
            net.Send(ply)
        end
    end
end) */