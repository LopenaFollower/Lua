game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pepper")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Coconut")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Playtime")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Honey")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Quest")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Battle")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Ability")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Goo")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Sunflower")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Dandelion")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Mushroom")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Blue Flower")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Clover")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Spider")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Bamboo")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Strawberry")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pineapple")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pumpkin")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Cactus")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Rose")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pine Tree")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Stump")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Wealth Clock")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Beesmas Feast")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Gingerbread House")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Free Royal Jelly Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Honey Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Treat Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Blueberry Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Strawberry Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Free Ant Pass Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Free Robo Pass Dispenser")
pcall(function()
	for _,v in pairs(game.Players.LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Quests.Content.Frame:GetChildren())do
		if v:IsA"Frame" then
			game.ReplicatedStorage.Events.GiveQuest:FireServer(v.TitleBar.Text)
			game.ReplicatedStorage.Events.CompleteQuest:FireServer(v.TitleBar.Text)
		end
	end
end)
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Brown Bear 2")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Polar Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Honey Bee")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Black Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Bucko Bee")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Riley Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Brown Bear 2")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Polar Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Honey Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Black Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Bucko Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Riley Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Treat Tutorial")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Treat Tutorial")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bonding With Bees")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bonding With Bees")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For A Sunflower Seed")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For A Sunflower Seed")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Gist Of Jellies")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Gist Of Jellies")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For Strawberries")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For Strawberries")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Binging On Blueberries")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Binging On Blueberries")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Royal Jelly Jamboree")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Royal Jelly Jamboree")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For Sunflower Seeds")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For Sunflower Seeds")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Picking Out Pineapples")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Picking Out Pineapples")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Seven To Seven")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Seven To Seven")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mother Bears Midterm")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mother Bears Midterm")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Eight To Eight")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Eight To Eight")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sights On The Stars")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Sights On The Stars")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Family Final")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Family Final")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Preliminary Research")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Preliminary Research")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Biology Study")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Biology Study")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Proving The Hypothesis")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Proving The Hypothesis")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bear Botany")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bear Botany")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Kingdom Collection")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Kingdom Collection")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Defensive Adaptions")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Devensive Adaptions")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Benefits Of Technology")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Benefits Of Technology")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Study")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Study")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Roses And Weeds")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Roses And Weeds")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Review")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Review")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ongoing Progress")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ongoing Progress")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red / Blue Duality")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red / Blue Duality")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Costs Of Computation")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Costs Of Computation")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollination Practice")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollination Practice")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Optimizing Abilities")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Optimizing Abilities")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ready For Infrared")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ready For Infrared")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Breaking Down Badges")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Breaking Down Badges")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Subsidized Agriculture")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Subsidized Agriculture")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Meticulously Crafted")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Meticulously Crafted")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Smart, Not Hard")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Smart, Not Hard")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Limits of Language")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Limits of Language")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Patterns and Probability")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Patterns and Probability")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Chemical Analysis")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Chemical Analysis")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mark Mechanics")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mark Mechanics")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Meditating On Phenomenon")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Meditating On Phenomenon")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beesperanto")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beesperanto")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Hive Minded Bias")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Hive Minded Bias")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mushroom Measurement Monotony")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mushroom Measurement Monotony")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Power Of Information")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Power Of Information")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Testing Teamwork")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Testing Teamwork")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Epistemological Endeavor")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Epistemological Endeavor")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Panda Bear")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Panda Bear")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Lesson On Ladybugs")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Lesson On Ladybugs")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhino Rumble")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhino Rumble")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beetle Battle")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beetle Battle")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Slayer")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Slayer")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ladybug Bonker")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ladybug Bonker")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Slayer 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Slayer 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhino Wrecking")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhino Wrecking")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Final Showdown")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Final Showdown")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Werewolf Hunter")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Werewolf Hunter")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Skirmish with Scorpions")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Skirmish with Scorpions")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mantis Massacre")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mantis Massacre")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The REAL Final Showdown")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The REAL Final Showdown")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ant Arrival")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ant Arrival")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Winged Wack Attack")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Winged Wack Attack")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Fire Fighter")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Fire Fighter")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Army Ant Assault")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Army Ant Assault")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colossal Combat")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colossal Combat")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Eager Exterminator")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Eager Exterminator")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Leaper Lickin'")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Leaper Lickin'")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colossal Combat 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colossal Combat 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Outrageous Onslaught")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Outrageous Onslaught")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Royal Rumble")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Royal Rumble")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 1")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 1")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 3")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 3")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 4")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 4")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 5")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 5")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 1")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 1")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 3")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 3")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 4")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 4")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 5")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 5")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Riley Bee")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Riley Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Bucko Bee")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Bucko Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sunflower Start")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Sunflower Start")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dandelion Deed")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Dandelion Deed")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red Request")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red Request")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Into The Blue")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Into The Blue")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Variety Fetcher")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Variety Fetcher")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bamboo Boogie")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bamboo Boogie")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red Request 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red Request 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Cobweb Sweeper")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Cobweb Sweeper")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Leisure Loot")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Leisure Loot")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("White Pollen Wrangler")
game.ReplicatedStorage.Events.GiveQuest:FireServer("White Pollen Wrangler")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pineapple Picking")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pineapple Picking")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Weed Wacker")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Weed Wacker")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red + Blue = Gold")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red + Blue = Gold")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colorless Collection")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colorless Collection")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit of Springtime")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit of Springtime")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Weed Wacker 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Weed Wacker 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 3")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 3")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Lucky Landscaping")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Lucky Landscaping")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Azure Adventure")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Azure Adventure")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pink Pineapples")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pink Pineapples")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Mushrooms")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Mushrooms")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Cobweb Sweeper 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Cobweb Sweeper 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rojo-A-Go-Go")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rojo-A-Go-Go")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pumpkin Plower")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pumpkin Plower")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 4")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 4")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bouncing Around Biomes")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bouncing Around Biomes")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Pineapples")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Pineapples")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rose Request")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rose Request")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For The White Clover")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For The White Clover")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Stomping Grounds")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Stomping Grounds")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Collecting Cliffside")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Collecting Cliffside")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mountain Meandering")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mountain Meandering")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Quest Of Legends")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Quest Of Legends")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("High Altitude")
game.ReplicatedStorage.Events.GiveQuest:FireServer("High Altitude")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blissfully Blue")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blissfully Blue")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rouge Round-up")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rouge Round-up")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("White As Snow")
game.ReplicatedStorage.Events.GiveQuest:FireServer("White As Snow")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Solo On The Stump")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Solo On The Stump")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colorful Craving")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colorful Craving")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pumpkins, Please!")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pumpkins, Please!")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Smorgasbord")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Smorgasbord")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 5")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 5")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("White Clover Redux")
game.ReplicatedStorage.Events.GiveQuest:FireServer("White Clover Redux")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Strawberry Field Forever")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Strawberry Field Forever")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Tasting The Sky")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Tasting The Sky")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Whispy and Crispy")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Whispy and Crispy")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Walk Through The Woods")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Walk Through The Woods")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Get Red-y")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Get Red-y")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("One Stop On The Tip Top")
game.ReplicatedStorage.Events.GiveQuest:FireServer("One Stop On The Tip Top")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Mushrooms 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Mushrooms 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pretty Pumpkins")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pretty Pumpkins")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Black Bear, Why?")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Black Bear, Why?")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bee A Star")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bee A Star")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit's Starter")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit's Starter")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The First Offering")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The First Offering")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rules of The Road")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rules of The Road")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("QR Quest")
game.ReplicatedStorage.Events.GiveQuest:FireServer("QR Quest")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pleasant Pastimes")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pleasant Pastimes")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Nature's Lessons")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Nature's Lessons")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Gifts Of Life")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Gifts Of Life")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Out-Questing Questions")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Out-Questing Questions")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Forcefully Friendly")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Forcefully Friendly")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sway Away")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Sway Away")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Memories of Memories")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Memories of Memories")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beans Becoming")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beans Becoming")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Do You Bee-lieve In Magic?")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Do You Bee-lieve In Magic?")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Ways Of The Winds / The Wind And Its Way")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Ways Of The Winds / The Wind And Its Way")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beauty Duty")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beauty Duty")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Witness Grandeur")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Witness Grandeur")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beeternity")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beeternity")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("A Breath Of Blue")
game.ReplicatedStorage.Events.GiveQuest:FireServer("A Breath Of Blue")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Glory Of Goo")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Glory Of Goo")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Tickle The Wind")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Tickle The Wind")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhubarb That Could Have Been")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhubarb That Could Have Been")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dreams Of Being A Bee")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Dreams Of Being A Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Sky Over The Stump")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Sky Over The Stump")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Space Oblivion")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Space Oblivion")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollenpalooza")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollenpalooza")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dancing With Stick Bug")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Dancing With Stick Bug")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bug Busser")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bug Busser")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bombs, Blueberries, and Bean Bugs")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bombs, Blueberries, and Bean Bugs")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bugs And Boosts")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bugs And Boosts")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Make It Hasty")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Make It Hasty")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Total Focus")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Total Focus")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("On Your Marks")
game.ReplicatedStorage.Events.GiveQuest:FireServer("On Your Marks")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Look In The Leaves")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Look In The Leaves")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("What About Sprouts")
game.ReplicatedStorage.Events.GiveQuest:FireServer("What About Sprouts")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bug Beatdown")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bug Beatdown")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bear Without Despair")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bear Without Despair")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit Spree")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit Spree")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Echoing Call")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Echoing Call")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spring Out Of The Mountain")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spring Out Of The Mountain")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Goo")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Goo")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Medley")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Medley")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Mushrooms")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Mushrooms")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Picnic")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Picnic")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Pollen")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Pollen")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Rampage")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Rampage")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Roses")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Roses")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Scavenge")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Scavenge")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Skirmish")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Skirmish")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Strawberries")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Strawberries")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Tango")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Tango")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Tour")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Tour")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bamboo Boogie 2: Bamboo Boogaloo")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bamboo Boogie 2: Bamboo Boogaloo")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rocky Red Mountain")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rocky Red Mountain")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Can't Without Ants")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Can't Without Ants")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The 15 Bee Zone")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The 15 Bee Zone")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bubble Trouble")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bubble Trouble")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Sweet And Sour")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sweet And Sour")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rare Red Clover")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rare Red Clover")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Low Tier Treck")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Low Tier Treck")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Okey-Pokey")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Okey-Pokey")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 6")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 6")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Capsaicin Collector")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Capsaicin Collector")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mountain Mix")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mountain Mix")
game.ReplicatedStorage.Events.GiveQuest:FireServer("You Blue It")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("You Blue It")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Variety Fetcher 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Variety Fetcher 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Getting Stumped")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Getting Stumped")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Weed Wacker 3")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Weed Wacker 3")
game.ReplicatedStorage.Events.GiveQuest:FireServer("All-Whitey Then")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("All-Whitey Then")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red Delicacy")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red Delicacy")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Boss Battles")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Boss Battles")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Myth In The Making")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Myth In The Making")
game.ReplicatedStorage.Events.GiveQuest:FireServer("")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("")