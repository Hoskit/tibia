local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 100000)
condition:setParameter(CONDITION_PARAM_SKILL_MELEEPERCENT, 200)
condition:setParameter(CONDITION_PARAM_SKILL_SHIELDPERCENT, 100)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setCondition(condition)

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
