extends "res://Assets/Scripts/Weapon.gd"

func _ready():
	damage = 50
	maxAmmo = 7
	currentAmmo = 7 
	shootSound = [preload("res://Assets/Sounds/gunshots/Deagle/Fatdeagle-1.wav"), preload("res://Assets/Sounds/gunshots/Deagle/Fatdeagle-2.wav"), preload("res://Assets/Sounds/gunshots/Deagle/Fatdeagle-3.wav")]
	reloadSound = preload("res://Assets/Sounds/foley/nGun - zReload 1.wav")
	bloodScale = [2, 2]
	casingScale = [1.5, 1.5]
	smokeScale = [1.5, 1.5]
