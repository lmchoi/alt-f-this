extends Node

var money: int = 0

signal money_changed(amount)

func earn_money(amount: int) -> void:
	money += amount
	money_changed.emit(money)
