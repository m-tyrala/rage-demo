extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var health
var armor
var attackSpeed
var attack
var lastAttackTimeStamp = 0
var bloodClass = load("res://src/scripts/blood.gd")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _init():
	health = 10
	armor = 0
	attackSpeed = 350
	attack = 1
	
	set_texture(load("res://video/static/Mada.png"))

func attack():
	if OS.get_ticks_msec() - lastAttackTimeStamp >= attackSpeed:
		lastAttackTimeStamp = OS.get_ticks_msec()
		attackSpeed = attackSpeed - 1
		return true
	else:
		return false

func decreaseHealth(bloodParent):
	var bloodNode = bloodClass.new(Color("dd0404"), Color("590303"), "none")
	bloodParent.add_child(bloodNode)
	bloodNode.set_name("blood" + str(health))
	bloodNode.set_pos(get_pos())
	health = health - 1