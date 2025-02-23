extends Control

# Reference to the WhalepassAPI node (handles external API interactions)
@onready var whalepass = $WhalepassAPI
# Reference to the container that will be shown or hidden based on request status
@onready var vbox_container = $VBoxContainer

# Updates the UI based on the request status
func _physics_process(_delta):
	# Show or hide the container depending on whether a request is active
	vbox_container.visible = not whalepass.is_request_active

# Triggered when the "Redirect Player" button is pressed
func _on_RedirectPlayerButton_pressed():
	# Sends a request to redirect the player via WhalepassAPI
	whalepass.redirect_player()

# Triggered when the "Increment Experience" button is pressed
func _on_IncrementExperienceButton_pressed():
	# Increments the player's experience with an example action ID
	whalepass.increment_player_experience("0")

# Triggered when the "Increment Experience" button is pressed
func _on_IncrementExperienceButton2_pressed():
	# Increments the player's experience with an example action ID
	whalepass.increment_player_experience2(10)
	
# Triggered when the "Complete Player Challenge" button is pressed
func _on_CompletePlayerChallenge_pressed():
	# Completes a specific challenge for the player
	whalepass.complete_player_challenge("challenge_id")

# Triggered when the "Get Player Progress" button is pressed
func _on_GetPlayerProgressButton_pressed():
	# Retrieves the current progress of the player
	whalepass.get_player_progress()

# Triggered when the "Get Player Progress" button is pressed
func _on_BattlepassProgressButton_pressed():
	# Retrieves the current progress of the player
	whalepass.get_battlepass_info(whalepass.battlepass_id, false, false)
