extends Node2D

onready var weapons = [preload("res://Pistol.tscn"), preload("res://DesertEagle.tscn"), preload("res://AssaultRifle.tscn")]
onready var currentWeapon = preload("res://Pistol.tscn")
onready var main = get_node("/root/Main")
onready var arBought = false
onready var deagleBought = false

func _ready():
	pass
	
func switch_weapon(weapon):
	if weapon == currentWeapon:
		return
		
	var toBeFree = get_child(0)
	toBeFree.queue_free()
	var weaponInst = weapon.instance()
	add_child(weaponInst)
	currentWeapon = weapon

func _unhandled_input(event):
	if event.is_action_pressed("1") && main.money >= 0 && !deagleBought:
		switch_weapon(weapons[1])
		deagleBought = true
		#main.money -= 200
	if event.is_action_pressed("2") && main.money >= 0 && !arBought:
		switch_weapon(weapons[2])
		arBought = true
		#main.money -= 500
