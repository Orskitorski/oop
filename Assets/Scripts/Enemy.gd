extends KinematicBody2D

onready var health: int
onready var speed: int
onready var isAlive = true
onready var deathTimer = $DeathTimer
onready var animPlayer = $AnimationPlayer
onready var hitbox = $Hitbox
onready var headHitbox = $HeadHitbox
onready var flashTimer = $FlashTimer
onready var sprite = $Sprite
onready var collisionBox = $CollisionObj/Collision
onready var main = get_node("/root/Main")
onready var playerHitBox = get_node("/root/Main/Player/HitBox")
onready var enemyType
onready var hitSounds = [preload("res://Assets/Sounds/fleshhits/1.wav"), preload("res://Assets/Sounds/fleshhits/2.wav"), preload("res://Assets/Sounds/fleshhits/3.wav"), preload("res://Assets/Sounds/fleshhits/4.wav"), preload("res://Assets/Sounds/fleshhits/5.wav"), preload("res://Assets/Sounds/fleshhits/6.wav"), preload("res://Assets/Sounds/fleshhits/7.wav"), preload("res://Assets/Sounds/fleshhits/8.wav"), preload("res://Assets/Sounds/fleshhits/9.wav"), preload("res://Assets/Sounds/fleshhits/10.wav")]
onready var opacity = 1

func _ready():
	pass

func _physics_process(_delta):
	if self.position.x > 0:
		self.position.x -= speed
	else:
		main.game_over()

func _process(_delta):
	
	self.z_index = self.position.y
	
	if isAlive:
		animPlayer.play("Move")
	
	if deathTimer.is_stopped() && !isAlive:
		queue_free()
		
	if flashTimer.is_stopped():
		sprite.modulate = Color(1, 1, 1)

func handle_hit(damage):
	main.play_sound(hitSounds[rand_range(0, 9)], 5)
	if isAlive:
		flashTimer.start()
		sprite.modulate = Color(2, 2, 2)
		health -= damage
		if health <= 0:
			hitbox.disabled = true
			collisionBox.disabled = true
			isAlive = false
			speed = 0
			deathTimer.start()
			animPlayer.play("Death")
			main.handle_score(enemyType)
