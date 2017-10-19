extends Sprite

var turn
var name
var velocity
var lastAttackTimeStamp = 0
var speed
var attackSpeed
var health
var texture
var bloodClass = load("res://src/scripts/blood.gd")

func _ready():
	pass
	
func _on_init(positionNode, scale, enemyId, enemyName, enemyTexture, enemySpeed, enemyAttackSpeed, enemyHealth):
	speed = enemySpeed
	attackSpeed = enemyAttackSpeed
	health = enemyHealth
	name = enemyName
	texture = enemyTexture
	set_texture(load(texture))
	turn = positionNode.get_name()
	
	set_pos(positionNode.get_pos())
	set_scale(scale)
	
	if turn == "UpPosition":
		velocity = Vector2(0,speed)
	elif turn == "DownPosition":
		velocity = Vector2(0,-speed)
	elif turn == "LeftPosition":
		velocity = Vector2(speed,0)
		set_scale(Vector2(-scale[0],scale[1]))
	elif turn == "RightPosition":
		velocity = Vector2(-speed,0)
		
	set_name(name + str(enemyId))
	set_texture(load(texture))

func checkPosition(up, down, left, right):
	if turn == "UpPosition":
		return get_pos()[1] < up
	if turn == "DownPosition":
		return get_pos()[1] > down
	if turn == "LeftPosition":
		return get_pos()[0] < left
	if turn == "RightPosition":
		return get_pos()[0] > right
		
func move(hero, bloodParent, sounds):
	if checkPosition():
		set_pos(get_pos() + velocity)
	else:
		if OS.get_ticks_msec() - lastAttackTimeStamp >= attackSpeed and not global.gameOver:
			lastAttackTimeStamp = OS.get_ticks_msec()
			var soundId = randi()%4+1
			sounds.play("hero" + str(soundId))
			print(get_name() + " is decreasing health")
			print("Texture? " + str(get_texture().get_path()))
			hero.decreaseHealth(bloodParent)
			
func decreaseHealth(hit, bloodParent, sounds):
	health = health - hit
	var bloodNode = bloodClass.new(Color("2a9609"), Color("083502"), turn)
	bloodParent.add_child(bloodNode)
	bloodNode.set_name("blood" + str(health))
	bloodNode.set_pos(get_pos() +  10 * velocity)
	var soundId = randi()%6+1
	sounds.play(name + str(soundId))
	return health > 0