extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nextToProtester = false
var nextToEntrance = false
var file = File.new()
var dict
var dialogue_counter = 1
var talkingToMan = false
var acceptInput = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBox.hide()
	$"Textbox Texture".hide()
	if global.pos2:
		$Player.position = global.pos2
	file.open("res://textfiles/OutsideOrchardDialogue.json", file.READ)
	var text = file.get_as_text()
	var result = JSON.parse(text)
	dict = result.result
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	_get_message()
	global.pos2 = $Player.position
	if $Player.position.distance_to($Position2D2.position)<50:
		get_tree().change_scene("res://FireScene.tscn")
func _display_next_dialogue():
	if dict.has(str(dialogue_counter)):
		$DialogueBox.clear()
		$DialogueBox.show()
		$"Textbox Texture".show()
		var display_text = dict[str(dialogue_counter)].content
		var speaker = dict[str(dialogue_counter)].name
		$DialogueBox.add_text(speaker + " : " + display_text)
		dialogue_counter+=1
	else:
		dialogue_counter = 1
		$DialogueBox.hide()
		$DialogueBox.clear()
		$"Textbox Texture".hide()
		talkingToMan = false
		
func _get_message():
	var distanceToProtester = $Sprite.position.distance_to($Player.position)
	var distanceToEntrance = $Position2D.position.distance_to($Player.position)
	if (distanceToProtester < 100):
		$Label.text = "PRESS F TO TALK TO MAN"
		nextToProtester = true
		nextToEntrance = false
	elif (distanceToEntrance < 100):
		$Label.text = "PRESS F TO ENTER THE ORCHARD"
		nextToProtester = false
		nextToEntrance = true
	else:
		$Label.text = ""
func _input(e):
	if acceptInput:
		if Input.is_key_pressed(KEY_F):
			if nextToProtester:
				_display_next_dialogue()
			elif nextToEntrance:
				print("entering scene")
				#global.timeSong = 0
				get_tree().change_scene("res://InsideOrchard.tscn")
		if $Timer.is_stopped():
			$Timer.start()
			acceptInput = false
	
func _on_Timer_timeout():
	acceptInput = true
