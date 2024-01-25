extends AudioStreamPlayer2D

@onready var stage_theme: AudioStreamPlayer2D = $StageTheme
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var tracks = [
	"res://assets/music/10. Guile's Theme [CPS-1].mp3",
	"res://assets/music/2-06 All-Star Rest Area.mp3"
]

var player = AudioStreamPlayer2D
var audio_stream = tracks[randi() % tracks.size()]
var song_index = randi() % tracks.size()


func _ready() -> void:
	randomize()
	shuffle_songs()


func shuffle_songs():
	tracks.shuffle()
	player.set_stream = load(audio_stream)


func _on_StageTheme_finished():
	shuffle_songs()
