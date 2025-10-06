--- STEAMODDED HEADER
--- MOD_NAME: Talisman
--- MOD_ID: Talisman
--- MOD_AUTHOR: [MathIsFun_, Mathguy24, jenwalter666, cg-223, lord.ruby]
--- MOD_DESCRIPTION: A mod that increases Balatro's score limit and skips scoring animations.
--- PREFIX: talisman
--- VERSION: 2.5

----------------------------------------------
------------MOD CODE -------------------------

if SMODS.Atlas then
  SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
  })
end

if SMODS.Sound then
	SMODS.Sound({
		key = "xchip",
		path = "MultiplicativeChips.wav"
	})
	SMODS.Sound({
		key = "echip",
		path = "ExponentialChips.wav"
	})
	SMODS.Sound({
		key = "eechip",
		path = "TetrationalChips.wav"
	})
	SMODS.Sound({
		key = "eeechip",
		path = "PentationalChips.wav"
	})
	SMODS.Sound({
		key = "emult",
		path = "ExponentialMult.wav"
	})
	SMODS.Sound({
		key = "eemult",
		path = "TetrationalMult.wav"
	})
	SMODS.Sound({
		key = "eeemult",
		path = "PentationalMult.wav"
	})
end


if SMODS.current_mod then
  function SMODS.current_mod.load_mod_config() end
  function SMODS.current_mod.save_mod_config() end
  SMODS.current_mod.config_tab = function()
    if Talisman and Talisman.config_tab then
      return Talisman.config_tab()
    end
    return nil
  end
  SMODS.current_mod.debug_info = function()
    if Talisman and Talisman.config_file then
      return {["Break Infinity"] = Talisman.config_file.break_infinity}
    end
    return {}
  end
  SMODS.current_mod.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2 }
  end
end
--[[SMODS.Joker{
  key = "test",
  name = "Joker Test",
  rarity = 4,
  discovered = true,
  pos = {x = 9, y = 2},
  cost = 4,
  loc_txt = {
      name = "Stat Stick",
      text = {
        "2 of {C:dark_edition,E:2,s:0.8}every scoring effect"
      }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {"#","{","}"}}
  end,
  calculate = function(self, card, context)
    if context.joker_main then
        return {
          mult_mod = 2,
          Xmult_mod = 2,
          Emult_mod = 2,
          EEmult_mod = 2,
          EEEmult_mod = 2,
          hypermult_mod = {22, 2},
          chip_mod = 2,
          Xchip_mod = 2,
          Echip_mod = 2,
          EEchip_mod = 2,
          EEEchip_mod = 2,
          hyperchip_mod = {22, 2}
        }
    end
  end,
}--]]

if SMODS and SMODS.Scoring_Calculation then
  local ref = SMODS.set_scoring_calculation
  function SMODS.set_scoring_calculation(key, ...)
      G.GAME.current_scoring_calculation_key = key
      if key == "talisman_hyper" then
          G.GAME.hyper_operator = G.GAME.hyper_operator or 2
      end
      return ref(key, ...)
  end

  SMODS.Scoring_Calculation:take_ownership("add", {order = -1}, true)
  SMODS.Scoring_Calculation:take_ownership("multiply", {order = 0}, true)
  SMODS.Scoring_Calculation:take_ownership("exponent", {order = 1}, true)
  function change_operator(amount)
      local order = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order + amount
      if not order then return end
      if G.GAME.current_scoring_calculation_key == "talisman_hyper" then
        G.GAME.hyper_operator = (G.GAME.hyper_operator or 2) + amount
        order = G.GAME.hyper_operator
      end
      local next = "add"
      local keys = {}
      for i, v in pairs(SMODS.Scoring_Calculations) do
        if v.order then
          keys[#keys+1] = i
        end
      end
      table.sort(keys, function(a, b) return SMODS.Scoring_Calculations[a].order < SMODS.Scoring_Calculations[b].order end)
      for i, v in pairs(keys) do
          if SMODS.Scoring_Calculations[v].order <= order then
            next = v
          end
      end
      if next then
        SMODS.set_scoring_calculation(next)
      end
  end

  SMODS.Scoring_Calculation {
    key = "hyper",
    func = function(self, chips, mult, flames) return to_big(chips):arrow(G.GAME.hyper_operator or 2, mult) end,
    text = function()
      if G.GAME.hyper_operator < 6 then
          local str = ""
          for i = 1, G.GAME.hyper_operator do str = str.."^" end
          return str
      else
        return "{"..G.GAME.hyper_operator.."}"
      end
    end,
    order = 2
  }
end

----------------------------------------------
------------MOD CODE END----------------------
