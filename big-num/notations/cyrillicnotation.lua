local lovely = require("lovely")
local nativefs = require("nativefs")
BaseLetterNotation = nativefs.load(Talisman.mod_path.."/big-num/notations/baseletternotation.lua")()

CyrillicNotation = {}
CyrillicNotation.__index = LetterNotation
setmetatable(CyrillicNotation, BaseLetterNotation)
CyrillicNotation.__tostring = function () return "CyrillicNotation" end

function CyrillicNotation:new(opt)
    opt = opt or {}
    return setmetatable({
        letters = "~абвгдежзиклмнопстуфхцчшщэюяАБВГДЕЖЗИКЛМНОПСТУФХЦЧШЩЭЮЯ",
        dynamic = opt.dynamic or false,
        reversed = opt.reversed or false
    }, CyrillicNotation)
end

return CyrillicNotation