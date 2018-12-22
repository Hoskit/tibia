local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)

local area = createCombatArea(AREA_CROSS6X6)
combat:setArea(area)

function onGetFormulaValues(player, level, maglevel)
	min = -((level) + (maglevel * 1.2) + 6)
	max = -((level) + (maglevel * 2.1) + 16)
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end
