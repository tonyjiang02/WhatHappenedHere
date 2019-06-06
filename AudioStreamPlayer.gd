extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.seek(global.timeSong)

func _process(delta):
	global.timeSong = self.get_playback_position()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
