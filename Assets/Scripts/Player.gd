extends KinematicBody2D

var health: int = 100 
export (int) var speed = 200
onready var playerSprite = $PlayerSprite
onready var playerAnim = $PlayerSprite/PlayerAnim

func _ready():
	pass

func _process(_delta):
	
	self.z_index = self.position.y
	
	#Movement
	var movement_direction := Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		movement_direction.y = -1
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1
		
	movement_direction = movement_direction.normalized()
	# warning-ignore:return_value_discarded
	move_and_slide(movement_direction * speed)
	
	#Animation
	
	if Input.is_action_pressed("up") || Input.is_action_pressed("down") || Input.is_action_pressed("right") || Input.is_action_pressed("left"):
		playerAnim.play("PlayerMove")
	else:
		playerAnim.play("PlayerAnim")
