extends Node3D

@onready var mainui = $MainUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainUI/Label.modulate.a = 0
	await get_tree().create_timer(1.0).timeout
	$Camera3D.make_current()
	$Sounds/ExtremeThunderWithRainKlickaud.play()
	var tween = create_tween()
	tween.tween_property($MainUI/Label, "modulate:a", 1.0, 2.0)
	tween.tween_property($MainUI/Label, "modulate:a", 0.0, 2.0).set_delay(1.5)
	tween.tween_callback(func(): $MainUI/Label.text = "In association with Quantum Corp")
	tween.tween_property($MainUI/Label, "modulate:a", 1.0, 2.0)
	tween.tween_property($MainUI/Label, "modulate:a", 0.0, 2.0).set_delay(1.0)
	tween.tween_property($MainUI/ColorRect, "modulate:a", 0.0, 2.0)
	tween.tween_callback(func(): $MainUI/Label.text = "Pistoloni Pizza"; $AnimationPlayer.play("Cutscene1"))
	tween.tween_property($MainUI/Label, "modulate:a", 1.0, 2.0)
	tween.tween_property($MainUI/Label, "modulate:a", 0.0, 2.0).set_delay(1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_extreme_thunder_with_rain_klickaud_finished() -> void:
	print("Restarting rain and thunder sound")
	$Sounds/ExtremeThunderWithRainKlickaud.play()
