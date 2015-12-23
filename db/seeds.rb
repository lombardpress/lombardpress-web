# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

commentary_list = [
	{
  commentaryid: "plaoulcommentary",
  blog: true,
  images: true
  }
]

commentary_list.each do |commentary|
  Setting.create(commentaryid: commentary[:commentaryid], blog: commentary[:blog], images: commentary[:images])
end

User.create(email: "admin@admin.com", password: "admin")


