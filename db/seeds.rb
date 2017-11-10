# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

millenials = Generation.create(name: "Millenials")
genx_boomers = Generation.create(name: "GenX/Boomers")

olivia = Friend.create(name: "Olivia", generation_id: millenials.id)
alex = Friend.create(name: "Alex", generation_id: millenials.id)
jesse = Friend.create(name: "Jesse", generation_id: millenials.id)
bekah = Friend.create(name: "Bekah", generation_id: millenials.id)
lindsay = Friend.create(name: "Lindsay", generation_id: millenials.id)

ForbiddenMatch.create(friend_1: alex, friend_2: jesse)
ForbiddenMatch.create(friend_1: olivia, friend_2: lindsay)

katie = Friend.create(name: "Katie", generation_id: genx_boomers.id)
mike = Friend.create(name: "Mike", generation_id: genx_boomers.id)
adam = Friend.create(name: "Adam", generation_id: genx_boomers.id)
santosh = Friend.create(name: "Santosh", generation_id: genx_boomers.id)
greg = Friend.create(name: "Greg", generation_id: genx_boomers.id)
debbie = Friend.create(name: "Debbie", generation_id: genx_boomers.id)
mark = Friend.create(name: "Mark", generation_id: genx_boomers.id)
kim = Friend.create(name: "Kim", generation_id: genx_boomers.id)

ForbiddenMatch.create(friend_1: katie, friend_2: mike)
ForbiddenMatch.create(friend_1: adam, friend_2: santosh)
ForbiddenMatch.create(friend_1: greg, friend_2: debbie)
ForbiddenMatch.create(friend_1: kim, friend_2: mark)

[alex, olivia, jesse, bekah, lindsay, katie, mike, adam, santosh, greg, debbie,
mark, kim].each { |f| ForbiddenMatch.create(friend_1: f, friend_2: f) }
