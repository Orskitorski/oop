extends Node

var smallZombie = preload("res://SmallZombie.tscn")
var bigZombie = preload("res://BigZombie.tscn")
var bloodSplat = preload("res://Blood.tscn")
var casings = preload("res://Casings.tscn")
var tracer = preload("res://Tracer.tscn")
var audioPlayer = preload("res://AudioPlayer.tscn")
onready var player = $Player
onready var weapon = $Player/WeaponManager.get_child(0)
onready var scoreText = $CanvasLayer/HUD/ScoreText
onready var moneyText = $CanvasLayer/HUD/MoneyText
onready var ammoCount = $CanvasLayer/HUD/AmmoCount
onready var gameOverText = $CanvasLayer/HUD/GameOverText
onready var spawnPosition = $SpawnPos
onready var smallSpawnTimer = $SmallSpawnTimer
onready var bigSpawnTimer = $BigSpawnTimer
onready var waveTimer = $WaveTimer
onready var music = $Music
onready var score = 0
onready var money = 0
onready var bigZombsSpawn = false

func _ready():
	pass

func _process(_delta):
	weapon = $Player/WeaponManager.get_child(0)
	
	ammoCount.text = ("Ammo: " + str(weapon.currentAmmo) + "/" + str(weapon.maxAmmo))
	scoreText.text = ("Score: " + str(score))
	moneyText.text = ("Money: " + str(money) + "$")
	
	if smallSpawnTimer.is_stopped():
		var smallZombieInst = smallZombie.instance()
		spawn(smallZombieInst)
		smallSpawnTimer.start()
	
	if bigSpawnTimer.is_stopped() && bigZombsSpawn:
		var bigZombieInst = bigZombie.instance()
		spawn(bigZombieInst)
		bigSpawnTimer.start()
	
	if !music.is_playing():
		music.play()
		
	if waveTimer.is_stopped():
		smallSpawnTimer.wait_time *= 0.9
		print(smallSpawnTimer.wait_time)
		waveTimer.start()
		if bigZombsSpawn:
			bigSpawnTimer.start()
			bigSpawnTimer.wait_time *= 0.9
			print(bigSpawnTimer.wait_time)
		
	if smallSpawnTimer.wait_time < 4:
		bigZombsSpawn = true
		
func particles(pos, particles, scaleX, scaleY):
	var particle = particles.instance()
	add_child(particle)
	particle.position = pos
	particle.scale.x *= scaleX
	particle.scale.y *= scaleY
	particle.z_index = player.z_index
	
func tracer(begin, end):
	var tracerInst = tracer.instance()
	add_child(tracerInst)
	tracerInst.position = begin.global_position
	tracerInst.scale.x = end.position.x
	tracerInst.z_index = player.z_index
	
func handle_score(enemyType):
	if enemyType == 1:
		RespawnMenu.handle_score(50)
		score+=50
		money+=10
	elif enemyType == 2:
		RespawnMenu.handle_score(100)
		score+=100
		money+=20
	print(score)
	
func play_sound(sound, volume):
	var audioPlayerInst = audioPlayer.instance()
	audioPlayerInst.stream = sound
	audioPlayerInst.volume_db = volume
	add_child(audioPlayerInst)
	
func game_over():
	get_tree().change_scene("res://RespawnMenu.tscn")
	
func spawn(type):
	spawnPosition.position.y = rand_range(250, 1000)
	add_child(type)
	type.position = spawnPosition.position
