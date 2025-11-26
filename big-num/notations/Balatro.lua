local lovely = require("lovely")
local nativefs = require("nativefs")
Notation = nativefs.load(Talisman.mod_path.."/big-num/notations/notation.lua")()
BalaNotation = {}
BalaNotation.__index = BalaNotation
BalaNotation.__tostring = function ()
    return "BalaNotation"
end
setmetatable(BalaNotation, Notation)

function BalaNotation:new()
    return setmetatable({}, BalaNotation)
end

function BalaNotation:format(n, places)
    --vanilla balatro number_format function basically
    local function e_ify(num)
        --if not num then return "0" end
        if is_big(num) then
            num = num:to_number()
        end
        if (num or 0) >= 10^6 then
            local x = string.format("%.4g",num)
            local fac = math.floor(math.log(tonumber(x), 10))
            return string.format("%.3f",x/(10^fac))..'e'..fac
        end
        return string.format(num ~= math.floor(num) and (num >= 100 and "%.0f" or num >= 10 and "%.1f" or "%.2f") or "%.0f", num):reverse():gsub("(%d%d%d)", "%1,"):gsub(",$", ""):reverse()
    end
    --The notation here is Hyper-E notation, but with lowercase E.
    if to_big(n:log10()) < to_big(1000000) then
        --1.234e56789
        if n.m then --BigNum
            local mantissa = math.floor(n.m*10^places+0.5)/10^places
            local exponent = n.e
            return mantissa.."e"..e_ify(exponent)
        elseif n.array[2] == 1 then --OmegaNum
            local mantissa = 10^(n.array[1]-math.floor(n.array[1]))
            mantissa = math.floor(mantissa*10^places+0.5)/10^places
            local exponent = math.floor(n.array[1])
            return (n.sign == -1 and "-" or "")..mantissa.."e"..e_ify(exponent)
        else
            local exponent = math.floor(math.log(n.array[1],10))
            local mantissa = n.array[1]/10^exponent
            mantissa = math.floor(mantissa*10^places+0.5)/10^places
            return (n.sign == -1 and "-" or "")..mantissa.."e"..e_ify(exponent)
        end
    elseif to_big(n:log10()) < to_big(10)^1000000 then
        --e1.234e56789
        if n.m then --BigNum
            local exponent = math.floor(math.log(n.e,10))
            local mantissa = n.e/10^exponent
            mantissa = math.floor(mantissa*10^places+0.5)/10^places
            return "e"..mantissa.."e"..e_ify(exponent)
        elseif n.array[2] == 2 then --OmegaNum
            local mantissa = 10^(n.array[1]-math.floor(n.array[1]))
            mantissa = math.floor(mantissa*10^places+0.5)/10^places
            local exponent = math.floor(n.array[1])
            return (n.sign == -1 and "-" or "").."e"..mantissa.."e"..e_ify(exponent)
        else
            local exponent = math.floor(math.log(n.array[1],10))
            local mantissa = n.array[1]/10^exponent
            mantissa = math.floor(mantissa*10^places+0.5)/10^places
            return (n.sign == -1 and "-" or "").."e"..mantissa.."e"..e_ify(exponent)
        end
    elseif n:isNaN() then
        return "nan"
    elseif not n.array or not (n.isFinite and n:isFinite()) then
        return "Infinity"
    elseif n.array[2] and n:arraySize() == 2 and n.array[2] <= 8 then
        --eeeeeee1.234e56789
        local mantissa = 10^(n.array[1]-math.floor(n.array[1]))
        mantissa = math.floor(mantissa*10^places+0.5)/10^places
        local exponent = math.floor(n.array[1])
        return (n.sign == -1 and "-" or "")..string.rep("e", n.array[2]-1)..mantissa.."e"..e_ify(exponent)
    elseif n:arraySize() < 8 then
        --e12#34#56#78
        local r = (n.sign == -1 and "-e" or "e")..e_ify(math.floor(n.array[1]*10^places+0.5)/10^places).."#"..e_ify(n.array[2] or 1)
        for i = 3, n:arraySize() do
            r = r.."#"..e_ify((n.array[i] or 0)+1)
        end
        return r
    else
        --e12#34##5678
        return (n.sign == -1 and "-e" or "e")..e_ify(math.floor(n.array[1]*10^places+0.5)/10^places).."#"..e_ify(n.array[n:arraySize()] or 0).."##"..e_ify(n:arraySize()-2)
    end
end

return BalaNotation