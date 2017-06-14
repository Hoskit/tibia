local config = {
	-- strong health potion
	[7588] = {health = {min = 575, max = 1150}, vocations = {1, 2, 3, 4}, text = 'everyone', level = 50, emptyId = 7634},
	-- strong mana potion
	[7589] = {mana = {min = 575, max = 1525}, vocations = {1, 2, 3, 4}, text = 'everyone', level = 50, emptyId = 7634},
	-- great mana potion
	[7590] = {mana = {min = 1750, max = 3050}, emptyId = 7635},
	-- great health potion
	[7591] = {health = {min = 725, max = 1575}, level = 80, emptyId = 7635},
	-- health potion
	[7618] = {health = {min = 425, max = 875}, emptyId = 7636},
	-- mana potion
	[7620] = {mana = {min = 375, max = 825}, emptyId = 7636},
	-- great spirit potion
	[8472] = {health = {min = 1250, max = 1750}, mana = {min = 500, max = 1000}, vocations = {3}, text = 'paladins', level = 80, emptyId = 7635},
	-- ultimate health potion
	[8473] = {health = {min = 3500, max = 5250}, level = 130, emptyId = 7635},
	-- antidote potion
	[8474] = {antidote = true, emptyId = 7636},
	-- small health potion
	[8704] = {health = {min = 300, max = 525}, emptyId = 7636}
}

local antidote = Combat()
antidote:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
antidote:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
antidote:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
antidote:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
antidote:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, (configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL) - 100))
-- 1000 - 100 due to exact condition timing. -100 doesn't hurt us, and players don't have reminding ~50ms exhaustion.

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local potion = config[item.itemid]
	if not potion then
		return true
	end

	if target.itemid ~= 1 or target.type ~= THING_TYPE_PLAYER then
		return false
	end

	if player:getCondition(CONDITION_EXHAUST_HEAL) then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
		return true
	end

	if potion.antidote and not antidote:execute(target, Variant(target.uid)) then
		return false
	end

	if (potion.level and player:getLevel() < potion.level)
			or (type(potion.vocations) == 'table' and not isInArray(potion.vocations, player:getVocation():getBase():getId()))
			and not (player:getGroup():getId() >= 2) then
		player:say(string.format('This potion can only be consumed by %s of level %d or higher.', potion.text, potion.level), TALKTYPE_MONSTER_SAY)
		return true
	end

	if type(potion.health) == 'table' and not doTargetCombatHealth(0, target, COMBAT_HEALING, potion.health.min, potion.health.max, CONST_ME_MAGIC_BLUE) then
		return false
	end

	if type(potion.mana) == 'table' and not doTargetCombatMana(0, target, potion.mana.min, potion.mana.max, CONST_ME_MAGIC_BLUE) then
		return false
	end

	player:addAchievementProgress('Potion Addict', 100000)

	player:addCondition(exhaust)
	doCreatureSayWithRadius(target, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)

	local topParent = item:getTopParent()
	if topParent.isItem and (not topParent:isItem() or topParent.itemid ~= 460) then
		local parent = item:getParent()
		if not parent:isTile() and (parent:addItem(potion.emptyId, 1) or topParent:addItem(potion.emptyId, 1)) then
			item:remove(1)
			return true
		end
	end

	Game.createItem(potion.emptyId, 1, item:getPosition())
	item:remove(1)
	return true
end
