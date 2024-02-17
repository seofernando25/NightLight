extends EventCommand

enum SanityChangeType { Set, Add }
@export var change_type = SanityChangeType.Set
@export var change_amount = 1

func Execute():
	if change_type == SanityChangeType.Set:
		PlayerFlags.sanity = change_amount
		return
	
	if change_type == SanityChangeType.Add:
		PlayerFlags.sanity += change_amount
		return