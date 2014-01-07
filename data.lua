local _, Cramp = ...
Cramp.data = {
	[105609] = { -- [梭克的尾巴尖端] HW
		SpellID  = 146250,
		Duration = 20,
		Cooldown = 155
	},
	[105491] = { -- [葛拉卡斯的邪惡之眼] HW
		SpellID  = 146245,
		Duration = 10,
		Cooldown = 55
	},
	[105459] = { -- [融合之火核心] HW
		SpellID  = 148899,
		Duration = 15,
		Cooldown = 85
	},
	[100500] = { -- [暴虐鬥士勝利徽章] S14
		SpellID  = 126679,
		Duration = 20,
		Cooldown = 60
	},
	[100505] = { -- [暴虐鬥士勝利徽記] S14
		SpellID  = 126700,
		Duration = 20,
		Cooldown = 50
	},
	[79327] = { -- [雪怒聖物]
		SpellID  = 128986,
		Duration = 15,
		Cooldown = 55
	}
}

-- Repeat
Cramp.data[105111] = Cramp.data[105609] -- [梭克的尾巴尖端] RF
Cramp.data[104862] = Cramp.data[105609] -- [梭克的尾巴尖端] F
Cramp.data[102305] = Cramp.data[105609] -- [梭克的尾巴尖端] N
Cramp.data[105360] = Cramp.data[105609] -- [梭克的尾巴尖端] NW
Cramp.data[104613] = Cramp.data[105609] -- [梭克的尾巴尖端] H

Cramp.data[104993] = Cramp.data[105491] -- [葛拉卡斯的邪惡之眼] RF
Cramp.data[104744] = Cramp.data[105491] -- [葛拉卡斯的邪惡之眼] F
Cramp.data[102298] = Cramp.data[105491] -- [葛拉卡斯的邪惡之眼] N
Cramp.data[105242] = Cramp.data[105491] -- [葛拉卡斯的邪惡之眼] NW
Cramp.data[104495] = Cramp.data[105491] -- [葛拉卡斯的邪惡之眼] H

Cramp.data[104961] = Cramp.data[105459] -- [融合之火核心] RF
Cramp.data[104712] = Cramp.data[105459] -- [融合之火核心] F
Cramp.data[102295] = Cramp.data[105459] -- [融合之火核心] N
Cramp.data[105210] = Cramp.data[105459] -- [融合之火核心] NW
Cramp.data[104463] = Cramp.data[105459] -- [融合之火核心] H