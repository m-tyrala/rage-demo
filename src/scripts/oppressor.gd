extends "res://src/scripts/enemy.gd"

func _ready():
	pass
	
func _init(positionNode, scale, enemyId):
	._on_init(positionNode, scale, enemyId, "oppressor", "res://video/static/oppressor.png", 4, 1000, 2)

func checkPosition():
	return .checkPosition(200, 400, 420, 602)
