local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_SUBID, 1)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
condition:setParameter(CONDITION_PARAM_TICKS, 1 * 100 * 1000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 100)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)
combat:setCondition(condition)

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
