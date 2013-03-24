namespace :hs do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Farooq Yousuf",
                 email: "farooqyousuf1@gmail.com",
                 password: "password",
                 password_confirmation: "password")
    User.create!(name: "Abeer Ayaz",
                 email: "abeer@example.com",
                 password: "password",
                 password_confirmation: "password")             
    Place.create!(name: "ADAMS Center",
                  address: "46903 Sugarland Road",
                  state: "Virginia",
                  city: "Sterling",
                  zipcode: "20164",
                  category: "Masjid",
                  description: "ISNA Masjid",
                  website: "adamscenter.org")
    Place.create!(name: "Al-Minhaal Academy",
                  address: "1764 New Durham Road",
                  state: "New Jersey",
                  city: "South Plainfield",
                  zipcode: "07080",
                  category: "Islamic School",
                  description: "Kids Islamic School in NJ",
                  website: "alminhaalacademy.com")
    Place.create!(name: "Al-Huda School",
                  address: "5301 Edgewood Road",
                  state: "Maryland",
                  city: "College Park",
                  zipcode: "21723",
                  category: "Islamic School",
                  description: "Kids Islamic School in MD",
                  website: "alhuda.org")
    Place.create!(name: "Dar Al Hijrah",
                  address: "3159 Row Street",
                  state: "Virginia",
                  city: "Falls Church",
                  zipcode: "22044",
                  category: "Masjid",
                  description: "MAS Masjid",
                  website: "hijrah.org")
    
  end
end