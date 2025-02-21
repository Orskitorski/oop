extends "res://Assets/Scripts/Weapon.gd"

func _ready():
	damage = 25
	maxAmmo = 8
	currentAmmo = 8 
	shootSound = [preload("res://Assets/Sounds/gunshots/Pistol/1911C-1.wav"), preload("res://Assets/Sounds/gunshots/Pistol/1911C-2.wav"), preload("res://Assets/Sounds/gunshots/Pistol/1911C-3.wav")]
	reloadSound = preload("res://Assets/Sounds/foley/nGun - zReload 1.wav")
	bloodScale = [1, 1]
	casingScale = [1, 1]
	smokeScale = [1, 1]
