extends Node

const grid_correspondence = {
	0: [0,0],
	1: [1,0],
	2: [2,0],
	3: [0,1],
	4: [1,1],
	5: [2,1],
	6: [0,2],
	7: [1,2],
	8: [2,2]
}

const grid_correspondence_2i = {
	0: Vector2i(0,0),
	1: Vector2i(1,0),
	2: Vector2i(2,0),
	3: Vector2i(0,1),
	4: Vector2i(1,1),
	5: Vector2i(2,1),
	6: Vector2i(0,2),
	7: Vector2i(1,2),
	8: Vector2i(2,2)
}

const reverse_grid_correspondence = {
	0: {0: 0, 1: 3, 2: 6},
	1: {0: 1, 1: 4, 2: 7},
	2: {0: 2, 1: 5, 2: 8}
}

const win_conditions = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
	[0, 4, 8],
	[2, 4, 6],
	[0, 3, 6],
	[1, 4, 7],
	[2, 5, 8]
]

const win_conditions_per_index = {
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

const pontuacoes = {
	-1: {
		-1: 90, 
		 0:  0, 
		 1: -5
		},
	0 : {
		-1: 0, 
		 0: 5, 
		 1: 10
		},
	1 : {
		-1: -5, 
		 0: 10, 
		 1: 100
		}
}

func check_win(vetor:Array) -> int:
	for win_condition in win_conditions:
		var aux = vetor[win_condition[0]] + vetor[win_condition[1]] + vetor[win_condition[2]] 
		if aux == 3 or aux == -3:
			return aux/3
	return 0

func check_draw(vetor:Array) -> bool:
	for win_condition in win_conditions:
		var aux = [vetor[win_condition[0]], vetor[win_condition[1]], vetor[win_condition[2]]]
		if not (1 in aux and -1 in aux):
			return false
	return true

func check_scores(vetor:Array) -> Array:
	var pontuacao = []
	for i in range(vetor.size()):
		if vetor[i] != 0:
			pontuacao.append(-INF)
		else:
			var aux = win_conditions_per_index[i].size()
			for win_condition in win_conditions_per_index[i]:
				aux += pontuacoes[vetor[win_condition[0]]][vetor[win_condition[1]]]
			pontuacao.append(aux)
	return pontuacao
