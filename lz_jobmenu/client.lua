local ESX = exports['es_extended']:getSharedObject()

if Config.Menu == true then
    RegisterCommand('+openjobmenu', function()
        openJobMenu()
    end)
    RegisterKeyMapping('+openjobmenu', 'Abrir Menú de trabajo', 'keyboard', Config.OpenKey)
end

if Config.Command == true then
     RegisterCommand(Config.CommandName, function()
         openJobMenu()
     end)
end


function openJobMenu()
        ESX.UI.Menu.CloseAll()

        Job = ((_U('job_name'))  .. ESX.GetPlayerData().job.label)
        Grade = ((_U('job_grade')) .. ESX.GetPlayerData().job.grade_label)
        Salary = ((_U('job_salary')) .. ESX.GetPlayerData().job.grade_salary)

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
