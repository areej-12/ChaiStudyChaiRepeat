extends Control

@onready var cup_sprite = $CupSprite as TextureRect
@onready var milk_button = $AddMilkButton
@onready var sugar_button = $AddSugarButton
@onready var back_to_study = $BackTostudyButton
@onready var brew_button = $StartBrewingButton
@onready var teabag_button = $AddTeaButton
@onready var instruction_label=$InstructionLabel
var current_stage = 0
var complete= false
var cup_states = [
	preload("res://Assets/empty.png"),   # 0: empty cup
	preload("res://Assets/milk.png"),    # 1: milk added
	preload("res://Assets/teabag.png"),  # 2: tea bag added
	preload("res://Assets/sugar.png"),   # 3: sugar added
	preload("res://Assets/brew.png")    # 4: chai ready
]
#var cup_states = [
	#preload("res://Assets/5.png"),   # 0: empty cup
	#preload("res://Assets/6.png"),    # 1: milk added
	#preload("res://Assets/7.png"),  # 2: tea bag added
	#preload("res://Assets/8.png"),   # 3: sugar added
	#preload("res://Assets/9.png")    # 4: chai ready
#]

func _ready() -> void:
	#milk_button.pressed.connect(_on_add_milk_button_pressed)
	#sugar_button.pressed.connect(_on_add_sugar_button_pressed)
	#teabag_button.pressed.connect(_on_add_tea_button_pressed)
	#brew_button.pressed.connect(_on_start_brewing_button_pressed)
	#back_to_study.pressed.connect(_on_back_tostudy_button_pressed)
	instruction_label.text="You have to make tea in order i.e 🥛🍃🍬🔥" 


	update_cup()
var chai_breaks = 0

func on_break_taken():
	Global.chai_breaks += 1
#-------------------------------------------
# Updates the cup sprite texture
#-------------------------------------------
func update_cup():
	if current_stage < cup_states.size():
		cup_sprite.texture = cup_states[current_stage]
	else:
		print("No more stages!")

#-------------------------------------------
# Button Functions
#-------------------------------------------
func _on_add_milk_button_pressed() -> void:
	if current_stage == 0:
		current_stage = 1
		instruction_label.text="Adding milk first!" 
		update_cup()
	else:
		#("You already added milk or missed a step!")
		#instruction_label.text="Adding milk first!"
		instruction_label.text="You  missed a step!"

func _on_add_tea_button_pressed() -> void:
	if current_stage == 1:
		current_stage = 2
		instruction_label.text="Adding teabag!"
		update_cup()
	else:
		#print("Add milk first!")
		instruction_label.text="You did not add milk .Add it first!"

func _on_add_sugar_button_pressed() -> void:
	if current_stage == 2:
		current_stage = 3
		instruction_label.text="Adding Sugar!"
		update_cup()
	else:
		#print("Add tea first!")
		instruction_label.text="You did not add teabag.Add it first!"

func _on_start_brewing_button_pressed() -> void:
	if current_stage == 3:
		current_stage = 4
		update_cup()
		instruction_label.text="☕ Perfect Chai is ready!"
		Global.chai_breaks += 1
		complete=true
	else:
		#print("Add all ingredients before brewing!")
		instruction_label.text="Add all ingredients before brewing!"

func _on_back_tostudy_button_pressed() -> void:

	if complete:
		get_tree().change_scene_to_file("res://GameSeq2.tscn")
	else:
		instruction_label.text="First make your chai then move to study session!"
		
	
