extends CharacterBody2D

@export var Flags : Node2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var goo : PackedScene = preload("res://dog/goo.tscn")

var flag_array : Array = []
var max_speed: float = 200.0
var acceleration: float = 800.0
var friction: float =400.0
var rng = RandomNumberGenerator.new()
var walk_step :int = 0
@onready var goo_spawner : Node2D = $GooSpawner

var world

func _ready() -> void:
	world = get_parent()
	for flag in Flags.get_children():
		flag_array.append(flag.global_position)
	nav_agent.set_target_position(flag_array[1])

func _physics_process(delta: float) -> void:
	if nav_agent:
		var next_nav_point = nav_agent.get_next_path_position()
		
		walk_step+=1
		
		if walk_step == 20:
			walk_step = 0
			var goo_instance = goo.instantiate()
			world.get_node("goo_world").add_child(goo_instance)
			goo_instance.global_position = goo_spawner.global_position
			goo_instance.rotation_degrees = rng.randf_range(-180,180)
		var direction = (next_nav_point - global_position).normalized()
		var target_angle = direction.angle()
		rotation = lerp_angle(rotation, target_angle, 3.0 * delta)
		var target_velocity = direction * max_speed
		
		velocity = velocity.move_toward(target_velocity, acceleration*delta)
		
		
		move_and_slide()
	
func _on_navigation_agent_2d_navigation_finished() -> void:
	var random_index = randi() % flag_array.size()
	nav_agent.set_target_position(flag_array[random_index])
	
