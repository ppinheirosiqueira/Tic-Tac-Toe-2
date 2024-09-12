extends Node
class_name IA

static func IA_step(dificuldade:int, player:int, big_tabuleiro:Array, tabuleiros:Array) -> Array:
	if dificuldade == -1: # Aleatório
		var tabuleiros_ativos = get_active_boards(tabuleiros)
		var random_tabuleiro = tabuleiros_ativos[randi() % tabuleiros_ativos.size()]
		var movimentos_possiveis = random_tabuleiro.get_movimentos_possiveis()
		if movimentos_possiveis.size() > 0:
			var random_index = randi() % movimentos_possiveis.size()
			var selected_position = movimentos_possiveis[random_index]
			return [tabuleiros.find(random_tabuleiro),selected_position]
	var tabuleiros_auxiliares = fazer_novos_tabuleiros(tabuleiros, player)
	var big_tabuleiro_auxiliar = big_tabuleiro if player == 1 else change_player_board(big_tabuleiro)
	#print("Player: ", player)
	#print("Big Tabuleiro: ", big_tabuleiro)
	#print("Big Tabuleiro Auxiliar: ", big_tabuleiro_auxiliar)
	#print("Tabuleiros originais: ")
	#print_tabuleiros(tabuleiros)
	#print("Tabuleiros modificados: ")
	#print_tabuleiros(tabuleiros_auxiliares)
	return melhor_movimento(definir_movimentos(tabuleiros_auxiliares, dificuldade, big_tabuleiro_auxiliar))

## Função feita para sempre tratar o jogador como número 1 e não -1
static func definir_movimentos(tabuleiros : Array, dificuldade: int, big_tabuleiro: Array) -> Dictionary:
	var movimentos = {}
	for index in tabuleiros.size():
		if tabuleiros[index].ativo:
			var peso_tabuleiro = WinConditions.check_big_scores(big_tabuleiro,index)
			WinConditions.check_scores(tabuleiros[index].posicoes, index, movimentos, peso_tabuleiro)

	if movimentos.is_empty():
		print("Por que nenhum está ativo?")
		return {0:0}

	if dificuldade == 0:
		return movimentos

	var movimentos_corrigidos:Dictionary = {}
	for key in movimentos.keys():
		for movimento in movimentos[key]:
			var novo_big_tabuleiro = big_tabuleiro.duplicate()
			var novos_tabuleiros = fazer_novos_tabuleiros(tabuleiros, 1)
			novo_big_tabuleiro[movimento[0]] = novos_tabuleiros[movimento[0]].move_occur(1,movimento[1])
			ativar_tabuleiro(movimento[1],novos_tabuleiros)
			if WinConditions.check_win(novo_big_tabuleiro) == 1: # se eu venço, volto na hora com esse movimento
				return {1000000000: [movimento]}
			if WinConditions.check_draw(novo_big_tabuleiro):
				WinConditions.add_to_dict(key, movimento, movimentos_corrigidos)
			else:
				inverter_tabuleiros(novos_tabuleiros)
				var pontuacao_adversario = definir_movimentos(novos_tabuleiros, dificuldade-1, change_player_board(novo_big_tabuleiro))
				WinConditions.add_to_dict(key - pontuacao_adversario.keys().max(), movimento, movimentos_corrigidos)
	return movimentos_corrigidos

static func fazer_novos_tabuleiros(tabuleiros:Array, player:int) -> Array:
	var novo_tabuleiro:Array[TabuleiroIA] = []
	for tabuleiro in tabuleiros:
		novo_tabuleiro.append(TabuleiroIA.new(tabuleiro.ativo, tabuleiro.posicoes if player == 1 else change_player_board(tabuleiro.posicoes), tabuleiro.winner if player == 1 else -tabuleiro.winner, tabuleiro.moves))
	return novo_tabuleiro

static func ativar_tabuleiro(index:int, tabuleiros:Array):
	if tabuleiros[index].winner != 0:
		for tabuleiro in tabuleiros:
			if tabuleiro.winner == 0:
				tabuleiro.ativo = true
		return
	for tabuleiro in tabuleiros:
		tabuleiro.ativo = false
	tabuleiros[index].ativo = true

static func melhor_movimento(movimentos: Dictionary) -> Array:
	var melhor_pontuacao = movimentos.keys().max()
	return movimentos[melhor_pontuacao][randi() % movimentos[melhor_pontuacao].size()]

static func inverter_tabuleiros(tabuleiros:Array) -> void:
	for tabuleiro in tabuleiros:
		tabuleiro.posicoes = change_player_board(tabuleiro.posicoes) 
		tabuleiro.winner = -tabuleiro.winner

static func change_player_board(vetor:Array) -> Array:
	var aux = []
	for i in range(len(vetor)):
		aux.append(-vetor[i])
	return aux

static func get_active_boards(boards:Array) -> Array:
	var boards_ativas = []
	for aux_board in boards:
		if aux_board.ativo:
			boards_ativas.append(aux_board)
	return boards_ativas

static func print_tabuleiros(tabuleiros:Array) -> void:
	for tabuleiro in tabuleiros:
		print(tabuleiro.posicoes)
		

class TabuleiroIA:
	var posicoes:Array 
	var ativo:bool
	var winner:int
	var moves: int

	func _init(ativado:bool, tabuleiro:Array, vencedor:int, movimentos_feitos:int) -> void:
		ativo = ativado
		posicoes = tabuleiro.duplicate()
		winner = vencedor
		moves = movimentos_feitos

	func move_occur(player:int , celula:int):
		moves += 1
		posicoes[celula] = player
		winner = WinConditions.check_win(posicoes)
		if moves == 9 and winner == 0:
			moves = 0
			posicoes = [0, 0, 0, 0, 0, 0, 0, 0, 0]
		elif winner != 0:
			ativo = false
		return winner
