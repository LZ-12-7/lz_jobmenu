local ESX = exports['es_extended']:getSharedObject()

Keys = {
    ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
    ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
    ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 116,  ["]"]   = 40,   ["ENTER"]   = 18,
    ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
    ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
    ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70,
    ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
    ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
    ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}

Citizen.CreateThread(function()
    while true do
        local _s = 1000
        if Config.Menu == true then
            _s = 0
            if IsControlJustPressed(1, Keys[Config.OpenKey]) then
                openJobMenu()
            end
        end
        Citizen.Wait(_s)
    end     
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if Config.Command == true then
            RegisterCommand(Config.CommandName, function()
                openJobMenu()
            end)
        end
    end     
end)


Citizen.CreateThread(function()
        while ESX.GetPlayerData() == nil do
            Wait(0)
        end
        PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(player)
    PlayerData = player
    end)
    
RegisterNetEvent('esx:setJob', function(job)
    PlayerData = ESX.GetPlayerData()
    PlayerData.job = job
end)

function openJobMenu()
        ESX.UI.Menu.CloseAll()

        Job = ((_U('job_name'))  .. PlayerData.job.label)
        Grade = ((_U('job_grade')) .. PlayerData.job.grade_label)
        Salary = ((_U('job_salary')) .. PlayerData.job.grade_salary)

    local elements = {
        {label = Job, value = '0'},
        {label = Grade, value = '0'},
        {label = Salary, value = '0'},
        {label = (_U('close_menu')), value = 'close'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jobmenu',{
        title = (_U('job_title')),
        align = 'bottom-right',
        elements = elements
    },

function(data, menu)
        if data.current.value == '0' then
    elseif data.current.value == 'close' then
        menu.close()
    end
end,

function(data, menu)
    menu.close()
    end)
end