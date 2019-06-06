extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal talk_muley
signal enter_house
var nextToHouse = false
var nextToMuley = false
var talkingToMuley = false
var file = File.new()
var dict = {}
var dialogue_counter = 1
var acceptInput = true
func _ready():
	if global.pos1:
		$Player.position = global.pos1
	$DialogueBox.hide()
	file.open("res://textfiles/dialogueMuley.json", file.READ)
	var text = file.get_as_text()
	var result = JSON.parse(text)
	dict = result.result
	file.close()
func _process(delta):
	_get_Message()
	global.pos1 = $Player.position
	if $Player.position.distance_to($Position2D.position)<50:
		get_tree().change_scene("res://OrchardScene.tscn")
func _input(e):
	if acceptInput:
		if Input.is_key_pressed(KEY_F):
			if nextToHouse:
				emit_signal("enter_house")
				print("enter house")
				get_tree().change_scene("res://InsideMuleyGravesHouse.tscn")
			if nextToMuley:
				emit_signal("talk_muley")
				print("talk_muley")
				_display_next_dialogue()
				talkingToMuley = true
		if Input.is_key_pressed(KEY_C):
			if talkingToMuley:
				_display_next_dialogue()
		if $Timer.is_stopped():
			acceptInput = false
			$Timer.start()
func _get_Message():
	var distanceToMuley = $MuleyGraves.position.distance_to($Player.position)
	var distanceToHouse = $DustBowlHouse.position.distance_to($Player.position)
	if (distanceToHouse < 100):
		$Label.text = "PRESS F TO ENTER HOUSE"
		nextToHouse = true
		nextToMuley = false
	if (distanceToMuley < 100):
		$Label.text = "PRESS F TO TALK TO MULEY"
		nextToHouse = false
		nextToMuley = true

func _display_next_dialogue():
	if dict.has(str(dialogue_counter)):
		$DialogueBox.clear()
		$DialogueBox.show()
		var display_text = dict[str(dialogue_counter)].content
		var speaker = dict[str(dialogue_counter)].name
		$DialogueBox.add_text(speaker + " : " + display_text)
		dialogue_counter+=1
	else:
		dialogue_counter = 1
		$DialogueBox.hide()
		$DialogueBox.clear()
		talkingToMuley = false


func _on_Timer_timeout():
	acceptInput = true
