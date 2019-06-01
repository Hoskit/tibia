local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

local area = createCombatArea(AREA_CROSS5X5)
combat:setArea(area)

function onGetFormulaValues(player, skill, attack, factor)
	local skillTotal, levelTotal = skill * attack, player:getLevel()
	return -(((skillTotal * 0.04) + 40) + (levelTotal*1)), -(((skillTotal * 0.05) + 60) + (levelTotal*1))
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
