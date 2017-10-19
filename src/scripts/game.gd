extends Node

onready var music = get_node("GameMusic")
onready var sounds = get_node("Sounds")
onready var blood = get_node("Blood")
onready var battlefield = get_node("Battlefield")
onready var upLayer = get_node("Battlefield/UpLayer")
onready var downLayer = get_node("Battlefield/DownLayer")
onready var leftLayer = get_node("Battlefield/LeftLayer")
onready var rightLayer = get_node("Battlefield/RightLayer")
onready var upPosition = get_node("Battlefield/UpPosition")
onready var downPosition = get_node("Battlefield/DownPosition")
onready var leftPosition = get_node("Battlefield/LeftPosition")
onready var rightPosition = get_node("Battlefield/RightPosition")
onready var animationPlayer = get_node("GameOver/GOSplash/GOSAnimation")

var heroClass = load("res://src/scripts/hero.gd")
var hero
var HERO_POSITION = Vector2(512,300)
var HERO_SCALE = Vector2(0.3,0.3)

var crawlerClass = load("res://src/scripts/crawler.gd")
var oppressorClass = load("res://src/scripts/oppressor.gd")
var drednaughtClass = load("res://src/scripts/drednaught.gd")
var new_enemy
var lastSpawnTime
var spawnRate = 800

var voice
var kills = 0

func _ready():
	voice = music.play("game")
	
	hero = heroClass.new()
	battlefield.add_child(hero)
	hero.set_name("Hero")
	hero.set_pos(HERO_POSITION)
	hero.set_scale(HERO_SCALE)
	
	lastSpawnTime = 0

	self.set_process(true)
	
func _process(delta):
	spawnEnemy()
	
	if Input.is_action_pressed("ui_cancel"):
		global.score = kills
		for i in range(5):
			music.set_volume_db(voice, music.get_volume_db(voice) - 2)
			OS.delay_msec(50)
		get_tree().change_scene("src/scenes/endGame.tscn")
	elif Input.is_action_pressed("ui_up"):
		if hero.attack() and not global.gameOver:
			hitEnemy(upLayer)
	elif Input.is_action_pressed("ui_down"):
		if hero.attack() and not global.gameOver:
			hitEnemy(downLayer)
	elif Input.is_action_pressed("ui_left"):
		if hero.attack() and not global.gameOver:
			hitEnemy(leftLayer)
	elif Input.is_action_pressed("ui_right"):
		if hero.attack() and not global.gameOver:
			hitEnemy(rightLayer)
	
	for node in get_node("Battlefield").get_children():
		if node extends CanvasLayer:
			for nodeChild in node.get_children():
				nodeChild.move(hero, blood, sounds)
				if hero.health <= 0:
					break
					
	if hero.health <= 0:
		gameOver()
	
func spawnEnemy():
	if OS.get_ticks_msec() - lastSpawnTime >= spawnRate:
		lastSpawnTime = OS.get_ticks_msec()
		spawnRate = spawnRate - 1
		var spawnPoint = randi()%4+1
		var enemyId = randi()%10000+1
		var enemyKind = randi()%3+1
		
		if spawnPoint == 1:
			spawn(enemyKind, enemyId, upPosition, upLayer)
		elif spawnPoint == 2:
			spawn(enemyKind, enemyId, downPosition, downLayer)
		elif spawnPoint == 3:
			spawn(enemyKind, enemyId, leftPosition, leftLayer)
		elif spawnPoint == 4:
			spawn(enemyKind, enemyId, rightPosition, rightLayer)

func spawn(enemyKind, enemyId, positionNode, parent):
	if enemyKind == 1:
		new_enemy = crawlerClass.new(positionNode, HERO_SCALE, enemyId)
		parent.add_child(new_enemy)
	elif enemyKind == 2:
		new_enemy = oppressorClass.new(positionNode, HERO_SCALE, enemyId)
		parent.add_child(new_enemy)
	elif enemyKind == 3:
		new_enemy = drednaughtClass.new(positionNode, HERO_SCALE, enemyId)
		parent.add_child(new_enemy)

func hitEnemy(layerNode):
	var tempEnemy
	if layerNode.get_name() == "UpLayer":
		for enemy in layerNode.get_children():
			if tempEnemy == null:
				tempEnemy = enemy
			else:
				if enemy.get_pos()[1] > tempEnemy.get_pos()[1]:
					tempEnemy = enemy
	elif layerNode.get_name() == "DownLayer":
		for enemy in layerNode.get_children():
			if tempEnemy == null:
				tempEnemy = enemy
			else:
				if enemy.get_pos()[1] < tempEnemy.get_pos()[1]:
					tempEnemy = enemy
	elif layerNode.get_name() == "LeftLayer":
		for enemy in layerNode.get_children():
			if tempEnemy == null:
				tempEnemy = enemy
			else:
				if enemy.get_pos()[0] > tempEnemy.get_pos()[0]:
					tempEnemy = enemy
	elif layerNode.get_name() == "RightLayer":
		for enemy in layerNode.get_children():
			if tempEnemy == null:
				tempEnemy = enemy
			else:
				if enemy.get_pos()[0] < tempEnemy.get_pos()[0]:
					tempEnemy = enemy
	
	if tempEnemy != null:
		var soundId = randi()%5+1
		sounds.play("hit_" + str(soundId))
		tempEnemy.decreaseHealth(hero.attack, blood, sounds)
		if tempEnemy.health <= 0:
			kills = kills + 1
			tempEnemy.free()
			
func gameOver():
	if (not animationPlayer.is_playing() and global.gameOver):
		get_tree().change_scene("src/scenes/endGame.tscn")
	elif not animationPlayer.is_playing():
		global.score = kills
		animationPlayer.play("GameOver")
		global.gameOver = true
		sounds.play("gameOver")
		for i in range(5):
			music.set_volume_db(voice, music.get_volume_db(voice) - 2)
			OS.delay_msec(70)