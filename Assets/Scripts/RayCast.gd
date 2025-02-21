extends Node

const max_length = 2000

onready var main = get_node("/root/Main")
onready var raycast = $RayCast2D
onready var end = $End
onready var begin = $Begin
onready var staticEnd = $StaticEnd

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if raycast.is_colliding():
		end.global_position = raycast.get_collision_point()
	else:
		end.global_position = staticEnd.position
