local evs=game.ReplicatedStorage.Events

-- unchecked: Sticker Hive Hub Mountain Top
local badges={"Honey","Quest","Battle","Ability","Goo","Playtime","Sticker","Sunflower","Dandelion","Mushroom","Blue Flower","Clover","Spider","Strawberry","Bamboo","Pineapple","Pumpkin","Cactus","Rose","Pine Tree","Stump","Coconut","Pepper","Hive Hub","Mountain Top"}
for _,v in pairs(badges)do
	evs.BadgeEvent:FireServer("Collect",v)
end

local dispensers={"Stockings","Wealth Clock","Beesmas Feast","Gingerbread House","Free Royal Jelly Dispenser","Honey Dispenser","Treat Dispenser","Blueberry Dispenser","Strawberry Dispenser","Free Ant Pass Dispenser","Free Robo Pass Dispenser"}
for _,v in pairs(dispensers)do
	evs.ToyEvent:FireServer(v)
end

local qps={"Brown Bear 2","Black Bear 2","Polar Bear","Honey Bee","Black Bear","Bucko Bee","Riley Bee"}
for _,v in pairs(qps)do
	evs.CompleteQuestFromPool:FireServer(v)
	evs.GiveQuestFromPool:FireServer(v)
end

function quest(name)
	evs.CompleteQuest:FireServer(name)
	evs.GiveQuest:FireServer(name)
end

pcall(function()
	for _,v in pairs(game.Players.LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Quests.Content.Frame:GetChildren())do
		if v:IsA"Frame"then
			quest(v.TitleBar.Text)
		end
	end
end)

local quests={"Treat Tutorial","Bonding With Bees","Search For A Sunflower Seed","The Gist Of Jellies","Search For Strawberries","Binging On Blueberries","Royal Jelly Jamboree","Search For Sunflower Seeds","Picking Out Pineapples","Seven To Seven","Mother Bears Midterm","Eight To Eight","Sights On The Stars","The Family Final","Preliminary Research","Biology Study","Proving The Hypothesis","Bear Botany","Kingdom Collection","Devensive Adaptions","Benefits Of Technology","Spider Study","Roses And Weeds","Blue Review","Ongoing Progress","Red / Blue Duality","Costs Of Computation","Pollination Practice","Optimizing Abilities","Ready For Infrared","Breaking Down Badges","Subsidized Agriculture","Meticulously Crafted","Smart, Not Hard","Limits of Language","Patterns and Probability","Chemical Analysis","Mark Mechanics","Meditating On Phenomenon","Beesperanto","Hive Minded Bias","Mushroom Measurement Monotony","The Power Of Information","Testing Teamwork","Epistemological Endeavor","Egg Hunt: Panda Bear","Lesson On Ladybugs","Rhino Rumble","Beetle Battle","Spider Slayer","Ladybug Bonker","Spider Slayer 2","Rhino Wrecking","Final Showdown","Werewolf Hunter","Skirmish with Scorpions","Mantis Massacre","The REAL Final Showdown","Ant Arrival","Winged Wack Attack","Fire Fighter","Army Ant Assault","Colossal Combat","Eager Exterminator","Leaper Lickin'","Colossal Combat 2","Outrageous Onslaught","Royal Rumble","Ultimate Ant Annihilation 1","Ultimate Ant Annihilation 2","Ultimate Ant Annihilation 3","Ultimate Ant Annihilation 4","Ultimate Ant Annihilation 5","Star Journey 1","Star Journey 2","Star Journey 3","Star Journey 4","Star Journey 5","Egg Hunt: Riley Bee","Egg Hunt: Bucko Bee","Sunflower Start","Dandelion Deed","Pollen Fetcher","Red Request","Into The Blue","Variety Fetcher","Bamboo Boogie","Red Request 2","Cobweb Sweeper","Leisure Loot","White Pollen Wrangler","Pineapple Picking","Pollen Fetcher 2","Weed Wacker","Red + Blue = Gold","Colorless Collection","Spirit of Springtime","Weed Wacker 2","Pollen Fetcher 3","Lucky Landscaping","Azure Adventure","Pink Pineapples","Blue Mushrooms","Cobweb Sweeper 2","Rojo-A-Go-Go","Pumpkin Plower","Pollen Fetcher 4","Bouncing Around Biomes","Blue Pineapples","Rose Request","Search For The White Clover","Stomping Grounds","Collecting Cliffside","Mountain Meandering","Quest Of Legends","High Altitude","Blissfully Blue","Rouge Round-up","White As Snow","Solo On The Stump","Colorful Craving","Pumpkins, Please!","Smorgasbord","Pollen Fetcher 5","White Clover Redux","Strawberry Field Forever","Tasting The Sky","Whispy and Crispy","Walk Through The Woods","Get Red-y","One Stop On The Tip Top","Blue Mushrooms 2","Pretty Pumpkins","Black Bear, Why?","Bee A Star","Spirit's Starter","The First Offering","Rules of The Road","QR Quest","Pleasant Pastimes","Nature's Lessons","The Gifts Of Life","Out-Questing Questions","Forcefully Friendly","Sway Away","Memories of Memories","Beans Becoming","Do You Bee-lieve In Magic?","The Ways Of The Winds / The Wind And Its Way","Beauty Duty","Witness Grandeur","Beeternity","A Breath Of Blue","Glory Of Goo","Tickle The Wind","Rhubarb That Could Have Been","Dreams Of Being A Bee","The Sky Over The Stump","Space Oblivion","Pollenpalooza","Dancing With Stick Bug","Bean Bug Busser","Bombs, Blueberries, and Bean Bugs","Bean Bugs And Boosts","Make It Hasty","Total Focus","On Your Marks","Look In The Leaves","What About Sprouts","Bean Bug Beatdown","Bear Without Despair","Spirit Spree","Echoing Call","Spring Out Of The Mountain","Riley Bee: Goo","Riley Bee: Medley","Riley Bee: Mushrooms","Riley Bee: Picnic","Riley Bee: Pollen","Riley Bee: Rampage","Riley Bee: Roses","Riley Bee: Scavenge","Riley Bee: Skirmish","Riley Bee: Strawberries","Riley Bee: Tango","Riley Bee: Tour","Bamboo Boogie 2: Bamboo Boogaloo","Rocky Red Mountain","Can't Without Ants","The 15 Bee Zone","Bubble Trouble","Sweet And Sour","Rare Red Clover","Low Tier Treck","Okey-Pokey","Pollen Fetcher 6","Capsaicin Collector","Mountain Mix","You Blue It","Variety Fetcher 2","Getting Stumped","Weed Wacker 3","All-Whitey Then","Red Delicacy","Boss Battles","MythITM","The Ways Of The Winds / The Wind And Its Ways"}
for _,v in pairs(quests)do
	quest(v)
end
