extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("pressed", self, "button_toggled")
func button_toggled():
	get_tree().change_scene("res://DustBowlScene.tscn")
