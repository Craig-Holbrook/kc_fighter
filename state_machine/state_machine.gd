extends Node
class_name StateMachine

var states := {}
var current_state: State
@export var initial_state: State


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(trigger_change_state)

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _physics_process(delta):
	#print(current_state.name)
	if current_state:
		current_state.update(delta)


func trigger_change_state(source_state: State, new_state_name: String):
	if source_state != current_state:
		return

	state_change(new_state_name)


func trigger_force_change_state(new_state_name: String):
	state_change(new_state_name)


func state_change(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
