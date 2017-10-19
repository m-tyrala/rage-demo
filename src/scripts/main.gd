extends Panel

onready var music = get_node("MenuMusic")
onready var start = get_node("Main/ItemList/Start")
onready var exit = get_node("Main/ItemList/Exit")
var voice

func _ready():
	start.connect("pressed", self, "start")
	exit.connect("pressed", self, "exit")
	voice = music.play("menu")

func start():
	music.play("gameStart")
	OS.delay_msec(1000)
	for i in range(10):
		music.set_volume_db(voice, music.get_volume_db(voice) - 2)
		OS.delay_msec(50)
	get_tree().change_scene("src/scenes/game.tscn")
	
func exit():
	get_tree().quit()