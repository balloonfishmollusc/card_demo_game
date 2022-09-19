extends Node

class_name Tech

var tech_stack = []

class _Tech:
	func _get_name() -> String:
		return "_Tech"
		
	func _get_desc() -> String:
		return "None"
		
	func _get_icon() -> String:
		return "res://icon.jpg"
	
	func _apply():
		pass
	
	func get_pl():
		return Q.get_p1()
	
	func _upgradable() -> bool:
		return false

class _UpgradableTech extends _Tech:
	func _get_name() -> String:
		return "_UpgradableTech"
	
	func _upgradable() -> bool:
		return true
	
class BuildingExtraIncome extends _UpgradableTech:
	func _get_name():
		return "建筑收益"
		
	func _get_desc():
		return "你的建筑增加5%的贝壳收益"
	
	func _apply():
		get_pl().building_extra_income += 0.05
	
class BuildingTimeReduction extends _UpgradableTech:
	func _get_name():
		return "加速建造"
	
	func _apply():
		get_pl().building_time_reduction += 1
	
class InstituteExtraPoints extends _UpgradableTech:
	func _get_name():
		return "强化学院"
	
	func _apply():
		get_pl().institute_extra_points += 2

class ExtraCardSlot extends _UpgradableTech:
	func _get_name():
		return "额外的卡槽"
	
	func _apply():
		pass
		


class MoreInitialCowries extends _Tech:
	func _get_name():
		return "初始贝壳"

	func _get_desc():
		return "立即获得500贝壳"

	func _apply():
		get_pl().cowries += 500
	
class ResearchOverTheAir extends _Tech:
	func _get_name():
		return "随手研发"
	
	func _apply():
		pass
		
class AdvancedBuildings extends _Tech:
	func _get_name():
		return "解锁高级建筑"
	
	func _apply():
		pass
		
class AdvancedSkills extends _Tech:
	func _get_name():
		return "解锁高级卡牌"
	
	func _apply():
		pass
	
class ExtraBuildingLevel extends _Tech:
	func _get_name():
		return "额外建造等级"
	
	func _apply():
		pass
		
class GreenFishingPort extends _Tech:
	func _get_name():
		return "绿色捕鱼"
	
	func _apply():
		pass

class EnlargedExploration extends _Tech:
	func _get_name():
		return "强化探索"
	
	func _apply():
		pass

class SuperStoneQuarry extends _Tech:
	func _get_name():
		return "超级采石场"
	
	func _apply():
		pass
		
class EnergyRecharge extends _Tech:
	func _get_name():
		return "恢复体力"
	
	func _apply():
		get_pl().energy_recharge += 3
		
class BuildingRecycle extends _Tech:
	func _get_name():
		return "回收"
	
	func _apply():
		pass
