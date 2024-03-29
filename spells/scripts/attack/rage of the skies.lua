local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BIGCLOUDS)

local area = createCombatArea(AREA_CROSS6X6)
combat:setArea(area)

function onGetFormulaValues(player, level, maglevel)
	min = -(level + (maglevel * 4) + 75)
	max = -(level + (maglevel * 10) + 150)
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
