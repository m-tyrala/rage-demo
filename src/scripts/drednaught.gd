extends "res://src/scripts/enemy.gd"

func _ready():
	pass
	
func _init(positionNode, scale, enemyId):
	._on_init(positionNode, scale, enemyId, "drednaught", "res://video/static/drednaught.png", 2, 1000, 3)

func checkPosition():
	return .checkPosition(220, 380, 450, 572)