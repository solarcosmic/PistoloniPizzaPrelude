extends Node3D

@onready var mainui = $MainUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_extreme_thunder_with_rain_klickaud_finished() -> void:
	print("Restarting rain and thunder sound")
	$Sounds/ExtremeThunderWithRainKlickaud.play()
