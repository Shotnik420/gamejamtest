extends Area2D
@export var move_speed: float = 300.0  # Movement speed towards the player

# Internal variables
var player: Node2D = null  # To store the reference to the player

# Called when the area enters another area (the player's area)
# Called every frame when processing is enabled
func _process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()  # Get direction vector
		get_parent().global_position += direction * move_speed * delta  # Move towards the player
		

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):  # Assuming player is in the 'player' group
		
		
		player = area  # Store a reference to the player
		set_process(true)  # Start processing movement


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):  # Assuming player is in the 'player' group
		
		
		player = null  # Store a reference to the player
		set_process(false)  # Start processing movement
