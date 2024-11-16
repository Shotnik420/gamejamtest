extends Node2D
class_name World
@onready var player : CharacterBody2D = $Player
@onready var cursor : TextureRect = $Cursor
var cursor_loc : Vector2 = Vector2(0,0)
func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	
	player_rotate_to_mouse()
	
func player_rotate_to_mouse():
	player.look_at(cursor_loc)

func _input(event):
	if event is InputEventMouseMotion:
		cursor_loc = event.position 
		cursor.global_position = Vector2(cursor_loc.x, cursor_loc.y)
