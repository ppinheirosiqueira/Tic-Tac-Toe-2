extends Node

const CIRCLE = preload("res://scenes/markers/circle.tscn")
const CROSS = preload("res://scenes/markers/cross.tscn")
const cenas:Dictionary[int,PackedScene] = {1: CIRCLE, -1: CROSS}

var choose_marker:int = 1
