extends Node3D

@onready var mainui = $MainUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sounds/ThunderRain1.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_thunder_rain_sound_finished() -> void:
	print("Restarting rain and thunder sound")
	$Sounds/ThunderRain1.play()
