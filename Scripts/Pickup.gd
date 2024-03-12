extends Area3D

@onready var hand = $"../Hand"
@onready var camera = get_parent()
var picked_object = null
var is_picked = false

func _physics_process(_delta):
	if picked_object and is_picked:
		var a = picked_object.global_transform.origin
		var b = hand.global_transform.origin
		picked_object.set_linear_velocity((b - a) * 4)

func _unhandled_input(_event):
	if (Input.is_action_just_pressed("picked")) and picked_object:
		if is_picked:
			picked_object = null
			is_picked = false
		else:
			is_picked = true
	
	if (Input.is_action_just_pressed("throw")) and picked_object and is_picked:
		var dir = -camera.global_transform.basis.z.normalized() + Vector3(0, 1, 0)
		picked_object.apply_central_impulse(dir * 10)
		picked_object = null
		is_picked = false

func _on_body_entered(body):
	if picked_object and is_picked:
		return
	picked_object = body
	
