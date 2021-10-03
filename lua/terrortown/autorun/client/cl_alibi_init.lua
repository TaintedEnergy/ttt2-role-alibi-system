net.Receive("ttt2SendRoleAlibi", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
		
		local str = net.ReadString()

		chat.AddText(Color( 255, 0, 0), "Your alibi role is: " .. LANG.TryTranslation(str))
end)