extends Node

const CIRCLE = preload("res://scenes/markers/circle.tscn")
const CROSS = preload("res://scenes/markers/cross.tscn")
const cenas:Dictionary[int,PackedScene] = {1: CIRCLE, -1: CROSS}

var choose_marker:int = 1
var prefered_language:String = "en_US"
var vitorias:Dictionary[String,Dictionary] = {}

func add_vitoria(name1:String, name2:String, winner:int) -> void:
	if winner == 1:
		vitorias[name1][name2][0] += 1
	elif winner == -1:
		vitorias[name1][name2][1] +=1
	else:
		vitorias[name1][name2][2] +=1
	var saved_game = SaveGame.new()
	saved_game.save_game()
	
func get_vitorias(name1:String, name2:String):
	if name1 not in vitorias.keys():
		vitorias[name1] = {}
		vitorias[name1][name2] = [0,0,0]
	else:
		if name2 not in vitorias[name1].keys():
			vitorias[name1][name2] = [0,0,0]
	return vitorias[name1][name2]
