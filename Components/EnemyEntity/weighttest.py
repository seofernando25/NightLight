

import random 

w = [('a', 0.2), ('b', 0.3), ('c', 0.5)]
total_weight = sum([x[1] for x in w])

counts = [0, 0, 0]


# Run experiment 1000 times
run_times = 10_00000
for i in range(run_times):
	r = random.random() * total_weight
	for i, (value, weight) in enumerate(w):
		r -= weight
		if r < 0:
			counts[i] += 1
			break

print("Expected: ", [run_times * x[1] for x in w])
print(counts) # [1000 * 0.2, 1000 * 0.3, 1000 * 0.5] = [200, 300, 500]