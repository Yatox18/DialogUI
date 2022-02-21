Controls = {}

function Controls:create(Key, KeyName, Desc, Selected)
    RegisterKeyMapping(KeyName, Desc, "keyboard", Key)
    RegisterCommand(KeyName, function(source, args)
        if (Selected ~= nil) then
            Selected()
        end
    end)
end
