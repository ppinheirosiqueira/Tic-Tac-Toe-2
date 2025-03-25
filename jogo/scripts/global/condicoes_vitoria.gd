extends Node
class_name WinConditions

const WIN_CONDITIONS = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
	[0, 4, 8],
	[2, 4, 6],
	[0, 3, 6],
	[1, 4, 7],
	[2, 5, 8]
]

const WIN_CONDITIONS_PER_INDEX = {
	0: [[1, 2], [4, 8], [3, 6]],
	1: [[0, 2], [4, 7]],
	2: [[0, 1], [4, 6], [5, 8]],
	3: [[4, 5], [0, 6]],
	4: [[3, 5], [0, 8], [2, 6], [1, 7]],
	5: [[3, 4], [2, 8]],
	6: [[7, 8], [0, 3], [2, 4]],
	7: [[6, 8], [1, 4]],
	8: [[6, 7], [0, 4], [2, 5]]
}

## 68/14/18
#const PONTUACOES = {
	#-1: {
		#-1: 90, 
		 #0:  0, 
		 #1: -5
		#},
	#0 : {
		#-1: 0, 
		 #0: 5, 
		 #1: 20
		#},
	#1 : {
		#-1: -5, 
		 #0: 20, 
		 #1: 100
		#}
#}

## 57/10/33
#const PONTUACOES = {
	#-1: {
		#-1:  8, 
		 #0: -5, 
		 #1: -5
		#},
	#0 : {
		#-1: -5, 
		 #0: 1, 
		 #1: 5
		#},
	#1 : {
		#-1: -5, 
		 #0: 5, 
		 #1: 10
		#}
#}

## 58/41/1 
const PONTUACOES = {
	-1: {
		-1: 90, 
		 0: -5, 
		 1: -5
		},
	0 : {
		-1: -5, 
		 0: 10, 
		 1: 50
		},
	1 : {
		-1: -5, 
		 0: 50, 
		 1: 100
		}
}

static func check_win(vetor:Array) -> int:
	for win_condition in WIN_CONDITIONS:
		var aux = vetor[win_condition[0]] + vetor[win_condition[1]] + vetor[win_condition[2]]
		if aux == 3 or aux == -3:
			return aux/3
	return 0

static func check_draw(vetor:Array) -> bool:
	for win_condition in WIN_CONDITIONS:
		var aux = [vetor[win_condition[0]], vetor[win_condition[1]], vetor[win_condition[2]]]
		if not (1 in aux and -1 in aux):
			return false
	return true

static func check_scores(vetor:Array, index_tabuleiro:int, pontuacoes:Dictionary, peso_grid:int):
	for i in range(vetor.size()):
		if vetor[i] == 0:
			var aux = 0
			for win_condition in WIN_CONDITIONS_PER_INDEX[i]:
				aux += PONTUACOES[vetor[win_condition[0]]][vetor[win_condition[1]]]
			add_to_dict(aux*peso_grid, [index_tabuleiro, i], pontuacoes)

static func add_to_dict(key, value:Array, my_dict:Dictionary):
	if my_dict.has(key):
		my_dict[key].append(value)
	else:
		my_dict[key] = [value]

static func check_big_scores(vetor:Array, posicao:int) -> int:
	var pontuacao:int = 0
	for win_condition in WIN_CONDITIONS_PER_INDEX[posicao]:
		pontuacao += PONTUACOES[vetor[win_condition[0]]][vetor[win_condition[1]]]
	return pontuacao
