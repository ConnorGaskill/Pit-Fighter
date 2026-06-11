extends VBoxContainer

class_name CombatButtonManager

var assigned_player : Player_Character

func decide_move(moves : Dictionary[Abstract_Combat_Move, bool]) -> void:
	show_buttons(moves)

func show_buttons(moves : Dictionary[Abstract_Combat_Move, bool]) -> void:

	clear_buttons()

	for move : Abstract_Combat_Move in moves:

		var button : Button = Button.new()

		button.text = move.name

		add_child(button)
			
		button.disabled = !moves[move]

		button.pressed.connect(
			func() -> void:
				clear_buttons()
				print("Move selected: ", move.name)		
				assigned_player.send_move(move))

func clear_buttons() -> void:
	for child : Node in get_children():
		child.queue_free()
