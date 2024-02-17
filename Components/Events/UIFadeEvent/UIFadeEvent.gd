extends EventCommand

enum FadeType { FADE_IN, FADE_OUT }
@export var fade_type: FadeType = FadeType.FADE_IN

func Execute():
	if UIAnimationPlayer.instance == null:
		push_error("UIAnimationPlayer is not found.")
		return
	
	if fade_type == FadeType.FADE_IN:
		await UIAnimationPlayer.instance.fade_in()
	else:
		await UIAnimationPlayer.instance.fade_out()
