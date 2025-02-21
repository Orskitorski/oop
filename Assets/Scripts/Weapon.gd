extends Node2D

onready var bloodParticle = preload("res://Blood.tscn")
onready var casingParticle = preload("res://Casings.tscn")
onready var smokeParticle = preload("res://Smoke.tscn")
onready var attackCooldown = $AttackCooldown
onready var animationPlayer = $AnimationPlayer
onready var recoilDuration = $RecoilDuration
onready var reloadTimer = $ReloadTimer
onready var raycast = $RayCast/RayCast2D
onready var gunSprite = $GunSprite
onready var ejectionPort = $EjectionPort
onready var begin = $RayCast/Begin
onready var end = $RayCast/End
onready var main = get_node("/root/Main")
onready var weapon
onready var damage
onready var maxAmmo
onready var currentAmmo
onready var shootSound
onready var reloadSound
onready var bloodScale = []
onready var casingScale = []
onready var smokeScale = []

func _ready():
	pass

func _process(_delta):
	
	if Input.is_action_pressed("R") && reloadTimer.is_stopped() && currentAmmo != maxAmmo && !animationPlayer.is_playing():
		reload()
	
	if recoilDuration.is_stopped():
		gunSprite.position = Vector2.ZERO

	if attackCooldown.is_stopped() && Input.is_action_pressed("click") && currentAmmo > 0 && reloadTimer.is_stopped() || attackCooldown.is_stopped() && Input.is_action_pressed(".") && currentAmmo > 0 && reloadTimer.is_stopped():
		shoot()
		
func shoot():
	
	animationPlayer.play("Shoot")
	
	currentAmmo -= 1
	
	main.particles(begin.global_position, smokeParticle, smokeScale[0], smokeScale[1])
	main.particles(ejectionPort.global_position, casingParticle, casingScale[0], casingScale[1])
	main.tracer(begin, end)
	main.play_sound(shootSound[rand_range(0, 2)], 0)
	
	var target = raycast.get_collider()
	print(target)
	
	if target != null && target.has_method("handle_hit"):
		if target.has_node("HeadHitbox") && (raycast.global_position.y >= target.get_node("HeadHitbox").global_position.y && raycast.global_position.y <= target.get_node("HeadHitbox").global_position.y-8):
			damage *= 2
			print("head")
		target.handle_hit(damage)
		main.particles(end.global_position, bloodParticle, bloodScale[0], bloodScale[1])
	
	recoilDuration.start()
	gunSprite.position.x -= 3
	
	attackCooldown.start()

func reload():
	main.play_sound(reloadSound, 0)
	animationPlayer.play("Reload")
	currentAmmo = maxAmmo
	reloadTimer.start()
