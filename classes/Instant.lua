UT.Instant = {}

function UT.Instant:startHeist()
    managers.network:session():spawn_players()
end

function UT.Instant:restartHeist()
    managers.game_play_central:restart_the_game()
end

function UT.Instant:finishHeist()
    local amountOfAlivePlayers = managers.network:session():amount_of_alive_players()
    managers.network:session():send_to_peers("mission_ended", true, amountOfAlivePlayers)
    game_state_machine:change_state_by_name("victoryscreen", {num_winners = amountOfAlivePlayers, personal_win = true})
end

function UT.Instant:leaveHeist()
    MenuCallbackHandler:_dialog_end_game_yes()
end
