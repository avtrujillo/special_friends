# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

millenials = Generation.create(name: "Millenials")
genx_boomers = Generation.create(name: "GenX/Boomers")

olivia = Friend.create(name: "Olivia", generation: millenials)
alex = Friend.create(name: "Alex", generation: millenials)
jesse = Friend.create(name: "Jesse", generation: millenials)
bekah = Friend.create(name: "Bekah", generation: millenials)
lindsay = Friend.create(name: "Lindsay", generation: millenials)

ForbiddenMatch.create(friend_1: alex, friend_2: jesse)
ForbiddenMatch.create(friend_1: olivia, friend_2: lindsay)

katie = Friend.create(name: "Katie", generation: genx_boomers)
mike = Friend.create(name: "Mike", generation: genx_boomers)
adam = Friend.create(name: "Adam", generation: genx_boomers)
santosh = Friend.create(name: "Santosh", generation: genx_boomers)
greg = Friend.create(name: "Greg", generation: genx_boomers)
debbie = Friend.create(name: "Debbie", generation: genx_boomers)
mark = Friend.create(name: "Mark", generation: genx_boomers)
kim = Friend.create(name: "kim", generation: genx_boomers)

ForbiddenMatch.create(friend_1: katie, friend_2: mike)
ForbiddenMatch.create(friend_1: adam, friend_2: santosh)
ForbiddenMatch.create(friend_1: greg, friend_2: debbie)
ForbiddenMatch.create(friend_1: kim, friend_2: mark)
