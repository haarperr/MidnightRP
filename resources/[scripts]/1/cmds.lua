Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', "/me", "")
    TriggerEvent('chat:addSuggestion', "/ooc", "Talk Out Of Character")
    TriggerEvent('chat:addSuggestion', "/trev", "Send a message as trevor to the server")
    TriggerEvent('chat:addSuggestion', "/ld", "Send a message as Lamar to the server")
    TriggerEvent('chat:addSuggestion', "/givekey", "[id] plate")
    TriggerEvent('chat:addSuggestion', "/ping", "send location [may not work]")
    TriggerEvent('chat:addSuggestion', "/bag", "open your bag")
    TriggerEvent('chat:addSuggestion', "/sit", "sit on closest chair")
    TriggerEvent('chat:addSuggestion', "/rob", "steal from a player [must have hands up] [may not work]")
end)