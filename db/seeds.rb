# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

MenuItem.destroy_all
Restaurant.destroy_all

r1 = Restaurant.create!(
  name: "Gudeg Yu Djum",
  address: "Yogyakarta",
  phone: "0274-123456",
  opening_hours: "06:00 - 19:00"
)

r1.menu_items.create!([
  { name: "Gudeg Komplit", price: 35000, category: "main", description: "Gudeg dengan krecek, telur, dan ayam kampung" },
  { name: "Gudeg Telur", price: 20000, category: "main", description: "Gudeg dengan telur" },
  { name: "Sambal Krecek", price: 15000, category: "side", description: "Krecek pedas nikmat" },
  { name: "Es Teh Manis", price: 5000, category: "drink", description: "Teh manis segar" },
  { name: "Es Jeruk", price: 7000, category: "drink", description: "Jeruk peras segar" }
])

r2 = Restaurant.create!(
  name: "Sate Khas Senayan",
  address: "Jakarta",
  phone: "021-987654",
  opening_hours: "10:00 - 22:00"
)

r2.menu_items.create!([
  { name: "Sate Ayam", price: 45000, category: "main", description: "Sate ayam dengan bumbu kacang halus" },
  { name: "Sate Kambing", price: 65000, category: "main", description: "Sate kambing muda empuk" },
  { name: "Gado-gado", price: 35000, category: "main", description: "Sayuran segar dengan bumbu kacang" },
  { name: "Tahu Telur", price: 30000, category: "side", description: "Tahu goreng dengan telur dan bumbu petis" },
  { name: "Es Dawet", price: 15000, category: "drink", description: "Dawet tradisional dengan santan dan gula merah" }
])
