extends Node

class_name Tech

func _on_p1_tech_level_up(new_lv) -> void:
	print(new_lv)

var tech_stack = []

class _Tech:
	func _get_name() -> String:
		return get_class()
		
	func _get_desc() -> String:
		return "None"
	
	func _apply():
		pass
	
	func get_pl():
		return Q.get_p1()
	
	func _upgradable() -> bool:
		return false

class _UpgradableTech extends _Tech:
	func _upgradable() -> bool:
		return true
	
class BuildingExtraIncome extends _UpgradableTech:
	func _apply():
		get_pl().building_extra_income += 0.05
	
class BuildingTimeReduction extends _UpgradableTech:
	func _apply():
		get_pl().building_time_reduction += 1
	
class InstituteExtraPoints extends _UpgradableTech:
	func _apply():
		get_pl().institute_extra_points += 2

class ExtraCardSlot extends _UpgradableTech:
	func _apply():
		pass
		


class MoreInitialCowries extends _Tech:
	func _apply():
		get_pl().cowries += 500
	
class ResearchOverTheAir extends _Tech:
	func _apply():
		pass
		
class AdvancedBuildings extends _Tech:
	func _apply():
		pass
		
class AdvancedSpells extends _Tech:
	func _apply():
		pass
	
class ExtraBuildingLevel extends _Tech:
	func _apply():
		pass
		
class GreenFishingPort extends _Tech:
	func _apply():
		pass

class EnlargedExploration extends _Tech:
	func _apply():
		pass

class SuperStoneQuarry extends _Tech:
	func _apply():
		pass
		
class EnergyRecharge extends _Tech:
	func _apply():
		get_pl().energy_recharge += 3
		
class BuildingRecycle extends _Tech:
	func _apply():
		pass
