extends TurnBasedPlayer

class_name Player

# Resources
var cowries: int = 500
var energy: int = 20
var tech_points: int = 0

# Properties
var building_extra_income: float = 0.0
var building_time_reduction: int = 0
var energy_recharge: int = 2
var institute_extra_points: int = 0

signal level_up(new_lv, options)

# 科技等级对应的点数
var tech_levels = {
	10: [
		Tech.BuildingExtraIncome.new(),
		Tech.MoreInitialCowries.new()
	],
	25: [
		Tech.BuildingTimeReduction.new(),
		Tech.EnergyRecharge.new(),
	],
	50: [
		Tech.InstituteExtraPoints.new(),
		Tech.ResearchOverTheAir.new(),
	],
	100: [
		Tech.BuildingExtraIncome.new(),
		Tech.ExtraCardSlot.new(),
	],
	200: [
		Tech.AdvancedBuildings.new(),
		Tech.AdvancedSkills.new(),
	],
	400: [
		Tech.InstituteExtraPoints.new(),
		Tech.BuildingRecycle.new(),
	],
	650: [
		Tech.BuildingTimeReduction.new(),
		Tech.SuperStoneQuarry.new(),
	],
	1000: [
		Tech.ExtraCardSlot.new(),
		Tech.EnlargedExploration.new(),
	],
	1500: [
		Tech.BuildingExtraIncome.new(),
		Tech.GreenFishingPort.new(),
	],
	2000: [
		Tech.BuildingTimeReduction.new(),
		Tech.ExtraBuildingLevel.new(),
	]
}

func get_tech_level() -> int:
	var i = 0
	for lv in tech_levels.keys():
		if self.tech_points >= lv:
			i += 1
		else:
			break
	return i

func get_tech_progress():
	var i = get_tech_level()
	return Vector3(
		tech_levels.keys()[i-1] if i>=1 else 0,
		tech_points,
		tech_levels.keys()[i]
	)

func add_tech_points(inc):
	var prev_lv = get_tech_level()
	self.tech_points += inc
	var new_lv = get_tech_level()
	assert(new_lv==prev_lv or new_lv-prev_lv==1)
	if new_lv-prev_lv == 1:
		var options = tech_levels.values()[new_lv-1]
		emit_signal("level_up", new_lv, options)

func _on_p1_turn_ready(player) -> void:
	# self.energy = int(min(20, self.energy+1))
	pass

func _on_p1_turn_submitted(player) -> void:
	pass
