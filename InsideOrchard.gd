extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal talk_picker
signal exit_house
var offStage = false
var nextToPicker = false
var talkingToPicker = false
var file = File.new()
var dict = {}
var dialogue_counter = 1
var acceptInput = true
func _ready():
	if global.pos1:
		$Player.position = global.pos1
	$DialogueBox.hide()
	file.open("res://textfiles/dialoguePicker.json", file.READ)
	var text = file.get_as_text()
	var result = JSON.parse(text)
	dict = result.result
	file.close()
func _process(delta):
	_get_Message()
	global.pos1 = $Player.position
	if $Player.position.distance_to($Position2D.position) < 50:
		print("closeto")
		get_tree().change_scene("res://OrchardScene.tscn")
func _input(e):
	if acceptInput:
		if Input.is_key_pressed(KEY_F):
			if nextToPicker:
				emit_signal("talk_picker")
				print("talk_picker")
				_display_next_dialogue()
				talkingToPicker = true
		if Input.is_key_pressed(KEY_C):
			if talkingToPicker:
				_display_next_dialogue()
		if $Timer.is_stopped():
			acceptInput = false
			$Timer.start()
func _get_Message():
	var distanceToPicker = $OrchardPicker.position.distance_to($Player.position)
	if (distanceToPicker < 100):
		$Label.text = "PRESS F TO TALK TO PICKER"
		nextToPicker = true

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
		talkingToPicker = false
		


func _on_Timer_timeout():
	acceptInput = true