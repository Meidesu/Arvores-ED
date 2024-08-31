extends Node2D

class_name No

@export var baseSeparation: int = 10;

@onready var left_pos: Marker2D = $leftPos as Marker2D;
@onready var right_pos: Marker2D = $rightPos as Marker2D;

var num: int;
var right: No;
var left: No;
var depth: int = 1;

func _ready():
	pass
	
func set_num(value:int):
	num = value;
	%Label.text = str(value);

func set_new_position(pos: Vector2, _depth):
	print("setando nova posição de alguem")
	global_position = pos;
	
	depth = _depth;
	left_pos.position.x += baseSeparation * -_depth;
	right_pos.position.x += baseSeparation * _depth;

func is_leaf(no: No):
	return !no.left && !no.right; 

func set_color(color: Color):
	#await get_tree().create_timer(0.5).timeout;
	await create_tween().tween_property(%bg, 'color', color, 0.5).finished;
