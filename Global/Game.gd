extends Node

const MAX_CASTLES = 3

var WASD_WINS = 0
var ARW_WINS = 0

var WASD_color = Color8(102, 177, 255)
var ARW_color = Color8(255, 119, 102)

var WASD_numcastles
var ARW_numcastles

var WASD_alive
var ARW_alive

var WINNER = "NONE"

func reset_max_castles():
	WASD_numcastles = MAX_CASTLES 
	ARW_numcastles = MAX_CASTLES 
