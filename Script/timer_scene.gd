extends Control

@onready var timer_label = $Timer_Label
@onready var timerlabel = $TimerLabel
@onready var start_button = $StartButton
@onready var pause_button = $PauseButton
@onready var resume_button = $ResumeButton
@onready var break_button = $BreakButton
@onready var focus_timer = $FocusTimer
@onready var bg_music = $backgroundMusic
@onready var music_button = $music
@onready var short_button = $ShortTimer
@onready var half_button = $HalfTimer
@onready var full_button = $FullTimer
@onready var motivation_label=$MotivationLabel
var total_time = 25 * 60
var time_left = total_time
var is_running = false
var is_break = false
var music_playing = true

func _ready():
	bg_music.volume_db = -20
	bg_music.play()

	music_button.pressed.connect(_on_music_pressed)
	short_button.pressed.connect(func(): start_focus(25))
	half_button.pressed.connect(func(): start_focus(50))
	full_button.pressed.connect(func(): start_focus(90))

	start_button.pressed.connect(_on_start_pressed)
	pause_button.pressed.connect(_on_pause_pressed)
	resume_button.pressed.connect(_on_resume_pressed)
	break_button.pressed.connect(_on_break_pressed)

	focus_timer.wait_time = 1.0
	focus_timer.timeout.connect(_on_timer_tick)
	update_label()

# 🕒 Starts the focus timer with selected duration
func start_focus(minutes: int) -> void:
	total_time = minutes * 60
	time_left = total_time
	is_running = true
	is_break = false
	focus_timer.start()
	timer_label.text = "Focus started for %d minutes!" % minutes
	

#😊MOtivation label fuction
#func motiavtion():
#var motivtation_sentence=[
#"Powered by chai, driven by deadlines!",
#"Focus now, chai later — that’s the real grind.",
#"No tea, no code — just chaos.",
#"One sip of chai and You are basically unstoppable!",
#"Stay calm and let the chai handle your motivation.",
#"We may be high on chai , but who cares☕!"
	#]
	#var random_quote = motivtation_sentence[randi() % motivtation_sentence.size()]
	#if not is_break:
		#timer_label.text = "Focus done! Time for chai ☕"
	#else:
		#timer_label.text = "Break over! Back to study 📚"
#
	#motivation_label.text = random_quote
	#motivation_label.modulate.a = 0
		##var random_quote = motivation_sentences[randi() % motivation_sentences.size()]
	#motivation_label.visible = true
	#motivation_label.text = random_quote
	#print("Quote shown:", random_quote)
#
	#var tween = get_tree().create_tween()
	#tween.tween_property(motivation_label, "modulate:a", 1.0, 1.5)
# ▶️ Manual Start
func _on_start_pressed():
	is_running = true
	is_break = false
	time_left = total_time
	focus_timer.start()
	Global.focus_total+=time_left
	update_label()

# ⏸️ Pause Timer
func _on_pause_pressed():
	is_running = false
	focus_timer.stop()
	update_label()

# 🔁 Resume Timer
func _on_resume_pressed():
	if not is_running:
		is_running = true
		focus_timer.start()
		update_label()

# ⏰ Timer Countdown
func _on_timer_tick():
	if not is_running:
		return

	time_left -= 1
	update_label()

	if time_left <= 0:
		focus_timer.stop()
		is_running = false
		if not is_break:
			timer_label.text = "Focus done! Time for chai ☕"
		else:
			timer_label.text = "Break over! Back to study 📚"

# ☕ Go to Mini-game Scene
func _on_break_pressed():
	get_tree().change_scene_to_file("res://ChaiMiniGame.tscn")
# 🧮 Update Timer Label
func update_label():
	#var motivtation_sentences=[
#"Powered by chai, driven by deadlines!",
#"Focus now, chai later — that’s the real grind.",
#"No tea, no code — just chaos.",
#"One sip of chai and You are basically unstoppable!",
#"Stay calm and let the chai handle your motivation.",
#"We may be high on chai , but who cares☕!"
	#]
	#
	var minutes = int(time_left / 60)
	var seconds = int(time_left % 60)
	timerlabel.text = "%02d:%02d" % [minutes, seconds]
	#var ranodom=motivtation_sentences[randi() % motivtation_sentences.size()]
	
# 🎵 Toggle Background Music
func _on_music_pressed() -> void:
	if music_playing:
		bg_music.stop()
		music_button.text = "🔇Music Off"
	else:
		bg_music.play()
		music_button.text = "🎵Music On"
	music_playing = !music_playing

func _on_breakbutton_pressed() -> void:
	is_break = true
	time_left = 5 * 60  # short break, 5 minutes
	focus_timer.start()
	is_running = true
	timer_label.text = "Focus now, chai later — that’s the real grind."
	Global.break_count+=1
	update_label()
