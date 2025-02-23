extends Node

@onready var http_request = $HTTPRequest
var player_id: String = ""

@export var game_id: String = ""  # Replace with your game ID
@export var api_key: String = ""  # Replace with your API Key
@export var battlepass_id: String = ""  # Replace with your Battlepass ID

var request_queue: Array = []  # Queue to handle pending requests
var is_request_active: bool = false  # Flag to track ongoing requests

var include_levels
var include_challenges

func _ready():
	print("ready")
	# Generates or retrieves the player_id
	player_id = load_player_id()
	if player_id == "":
		player_id = generate_player_id()
		save_player_id(player_id)

	# Call the function to register the player
	enroll_player()

# Function to generate a unique player_id
func generate_player_id() -> String:
	return str(Time.get_unix_time_from_system()) + str(randi()).md5_text()

func save_player_id(_id: String):
	var file = FileAccess.open("user://player_id.txt",FileAccess.WRITE)
	file.store_string(player_id)
	file.close()

func load_player_id() -> String:
	var file = FileAccess.open("user://player_id.txt",FileAccess.WRITE)
	var saved_id = file.get_as_text().strip_edges()
	file.close()
	return saved_id
	#return ""

# Queues a new HTTP request
func queue_request(url: String, headers: Dictionary, method: int, data = null):
	request_queue.append({"url": url, "headers": headers, "method": method, "data": data})
	if not is_request_active:
		_process_next_request()

func _process_next_request():
	if request_queue.size() > 0:
		is_request_active = true
		var request = request_queue.pop_front()
		var header_array: PackedStringArray = []
		for key in request.headers.keys():
			header_array.append(key + ": " + request.headers[key])

		var err = http_request.request(request.url, header_array, request.method, JSON.new().stringify(request.data) if request.data else "")
		if err != OK:
			print("Failed to send request: ", err)

	else:
		is_request_active = false

func enroll_player():
	var url = "https://api.whalepass.gg/enrollments"
	var data = {
		"playerId": player_id,
		"gameId": game_id
	}
	var headers = {
		"X-API-KEY": api_key,
		"X-Battlepass-Id": battlepass_id,
		"Content-Type": "application/json"
	}
	queue_request(url, headers, HTTPClient.METHOD_POST, data)

func redirect_player():
	var url = "https://api.whalepass.gg/players/" + player_id + "/redirect?gameId=" + game_id
	var headers = {
		"X-API-KEY": api_key,
		"X-Battlepass-Id": battlepass_id
	}
	queue_request(url, headers, HTTPClient.METHOD_GET)

func increment_player_experience(action_id: String):
	var url = "https://api.whalepass.gg/players/" + player_id + "/progress/action"
	var data = {
		"gameId": game_id,
		"actionId": action_id
	}
	var headers = {
		"X-API-KEY": api_key,
		"X-Battlepass-Id": battlepass_id,
		"Content-Type": "application/json"
	}
	queue_request(url, headers, HTTPClient.METHOD_POST, data)

func increment_player_experience2(additional_exp: int):
	var url = "https://api.whalepass.gg/players/" + player_id + "/progress/exp"
	var data = {
		"gameId": game_id,
		"additionalExp": additional_exp
		}
	var headers = {
		"X-API-KEY": api_key,
		"X-Battlepass-Id": battlepass_id,
		"Content-Type": "application/json"
	}
	queue_request(url, headers, HTTPClient.METHOD_POST, data)

func complete_player_challenge(challenge_id: String):
	var url = "https://api.whalepass.gg/players/" + player_id + "/progress/challenge"
	var data = {
		"gameId": game_id,
		"challengeId": challenge_id
	}
	var headers = {
		"X-API-KEY": api_key,
		"X-Battlepass-Id": battlepass_id,
		"Content-Type": "application/json"
	}
	queue_request(url, headers, HTTPClient.METHOD_POST, data)

func get_player_progress():
	var url = "https://api.whalepass.gg/players/" + player_id + "/progress/base?gameId=" + game_id
	var headers = {
		"X-API-KEY": api_key,
		"X-Battlepass-Id": battlepass_id
	}
	queue_request(url, headers, HTTPClient.METHOD_GET)

func get_battlepass_info(battlepass_id: String, include_levels: bool = false, include_challenges: bool = false):
	# Build the URL with parameters based on the function arguments
	var url = "https://api.whalepass.gg/battlepass/" + battlepass_id + "?includeLevels=" + str(include_levels).to_lower() + "&includeChallenges=" + str(include_challenges).to_lower()
	var headers = {
		"X-API-KEY": api_key,
		"X-Battlepass-Id": battlepass_id
	}
	queue_request(url, headers, HTTPClient.METHOD_GET)
	
	
# Handles the completion of an HTTP request
func _on_HTTPRequest_request_completed(_result, response_code, _headers, body):
	is_request_active = false
	_process_next_request()

	var body_string = body.get_string_from_utf8()
	print("HTTP Response: ", response_code, body_string)

	if response_code == 200:
		print("Request successful!")
	else:
		print("Request failed with code: ", response_code)
