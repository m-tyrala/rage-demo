extends Particles2D

func _init(color, colorDark, direction):
	set_color_phases(2)
	set_color_phase_pos(0,0)
	set_color_phase_color(0, color)
	set_color_phase_pos(1,1)
	set_color_phase_color(1, colorDark)
	set_param(Particles2D.PARAM_GRAVITY_STRENGTH, 600)
	if direction == "UpPosition":
		set_param(Particles2D.PARAM_DIRECTION, 180)
		set_param(Particles2D.PARAM_GRAVITY_DIRECTION, 180)
	elif direction == "DownPosition":
		set_param(Particles2D.PARAM_DIRECTION, 0)
		set_param(Particles2D.PARAM_GRAVITY_DIRECTION, 0)
	elif direction == "LeftPosition":
		set_param(Particles2D.PARAM_DIRECTION, 270)
		set_param(Particles2D.PARAM_GRAVITY_DIRECTION, 270)
	elif direction == "RightPosition":
		set_param(Particles2D.PARAM_DIRECTION, 90)
		set_param(Particles2D.PARAM_GRAVITY_DIRECTION, 90)

func _ready():
	set_amount(300)
	set_lifetime(0.4)
	set_time_scale(1)
	set_emit_timeout(0.2)
	set_explosiveness(0.9)
	set_param(Particles2D.PARAM_SPREAD,90)
	set_param(Particles2D.PARAM_LINEAR_VELOCITY, 120)
	set_param(Particles2D.PARAM_INITIAL_SIZE, 2)
	set_param(Particles2D.PARAM_FINAL_SIZE, 6)