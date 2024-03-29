local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)

local area = createCombatArea(AREA_BEAM7, AREADIAGONAL_BEAM7)
combat:setArea(area)

function onGetFormulaValues(player, level, maglevel)
	min = -(level + (maglevel * 3.6) + 22)
	max = -(level + (maglevel * 6) + 37)
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
