# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Organization.create(
  name: "CASA - Centro de Apoio ao Sem-Abrigo",
  address: "Rua Ladislau Parreira, 22",
  phone_number: "Susana Marques - 914 222 377",
  email: "setubal@casa-apoioaosemabrigo.org",
  category: "Sem-Abrigo",
  description: "Auxiliar aqueles que se encontram em situação de Sem-Abrigo, que integrem Famílias em Risco ou Famílias Carênciadas, através de ações de solidariedade social, disponibilizando um contacto próximo, bens alimentares, artigos de vestuário e serviços de reintegração social, independentemente do estrato social, etnia, religião ou género.",
  city: "Setúbal",
  zip_code: "2900-174",
  country: "Portugal"
  )
