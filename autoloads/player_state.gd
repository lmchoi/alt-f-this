extends Node

var money: int = 0
var chaos: int = 0

signal money_changed(amount)
signal chaos_changed(amount)

func earn_money(amount: int) -> void:
	money += amount
	money_changed.emit(money)

func increase_chaos(amount: int) -> void:
	chaos += amount
	chaos_changed.emit(chaos)
