extends Panel

onready var playAgain = get_node("Main/UI/PlayAgain")
onready var backToMenu = get_node("Main/UI/BackToMenu")
onready var score = get_node("Main/UI/Score")
onready var music = get_node("MenuMusic")
var voice

func _ready():
	global.gameOver = false
	playAgain.connect("pressed",self,"playAgain")
	backToMenu.connect("pressed",self,"backToMenu")
	score.set_text("enemies killed: " + str(global.score))
	voice = music.play("menu")

func playAgain():
	music.play("gameStart")
	OS.delay_msec(1000)
	for i in range(10):
		music.set_volume_db(voice, music.get_volume_db(voice) - 2)
		OS.delay_msec(50)
	get_tree().change_scene("src/scenes/game.tscn")
	
func backToMenu():
	music.play("backToMenu")
	OS.delay_msec(1000)
	for i in range(10):
		music.set_volume_db(voice, music.get_volume_db(voice) - 2)
		OS.delay_msec(50)
	get_tree().change_scene("src/scenes/main.tscn")
