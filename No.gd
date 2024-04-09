extends Node2D

class_name No

@onready var left_pos: Marker2D = $leftPos as Marker2D;
@onready var right_pos: Marker2D = $rightPos as Marker2D;

var num: int;
var right: No;
var left: No;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_num(value:int):
	num = value;
	%Label.text = str(value);

func set_new_position(pos: Vector2):
	print("setando nova posição de alguem")
	global_position = pos;
