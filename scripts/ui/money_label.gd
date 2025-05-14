class_name MoneyLabel
extends Label

@export var prefix := "$"
@export var animate_scale := true

@onready var initial_scale := scale

func update_amount(new_amount: int):
	text = prefix + str(new_amount)
	#_play_scale_animation()

func _play_scale_animation():
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", initial_scale * 1.2, 0.15)
	tween.tween_property(self, "scale", initial_scale, 0.35)
