local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLCLOUDS)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)

local condition = Condition(CONDITION_CURSED)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)

local damageTable = {
	{id = 1, -450, -400, -350, -340},
	{id = 2, -330, -320, -310, -300},
	{id = 3, -290, -250, -240},
	{id = 4, -230, -200},
	{id = 5, -190, -150},
	{id = 6, -100},
	{id = 10, -50}
}

for i = 1, #damageTable do
	local t = damageTable[i]
	for j = 1, #t do
		condition:addDamage(t.id, 3000, t[j])
	end
end

combat:setCondition(condition)

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end