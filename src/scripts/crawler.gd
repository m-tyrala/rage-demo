extends "res://src/scripts/enemy.gd"

func _ready():
	pass
	
func _init(positionNode, scale, enemyId):
		._on_init(positionNode, scale, enemyId, "crawler", "res://video/static/crawler.png", 6, 1000, 1)
	
func checkPosition():
	return .checkPosition(220, 380, 420, 602)