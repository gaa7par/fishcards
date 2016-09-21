admin = "admin"
users = %w(alpha bravo charlie delta echo foxtrot golf hotel india juliet kilo lima mike november oscar papa quebec romeo sierra tango uniform victor whiskey x-ray yankee zulu)

languages = {
  "Spanish" => {
    front: ["el hombre", "la mujer", "el niño", "la niña", "el perro", "el gato", "la manzana"],
    back: ["the man", "the woman", "the boy", "the girl", "the dog", "the cat", "the apple"]
  },

  "French" => {
    front: ["l'homme", "la femme", "le garçon", "la fille", "le chien", "le chat", "la pomme"],
    back: ["the man", "the woman", "the boy", "the girl", "the dog", "the cat", "the apple"]
  },

  "German" => {
    front: ["der Mann", "die Frau", "der Junge", "das Mädchen", "der Hund", "die Katze", "das Apfel"],
    back: ["the man", "the woman", "the boy", "the girl", "the dog", "the cat", "the apple"]
  },

  "Italian" => {
    front: ["l'oumo", "la donna", "il ragazzo", "la ragazza", "il cane", "il gatto", "la mela"],
    back: ["the man", "the woman", "the boy", "the girl", "the dog", "the cat", "the apple"]
  },

  "Portuguese" => {
    front: ["o homem", "a mulher", "o menino", "a menina", "o cachorro", "o gato", "a maçã"],
    back: ["the man", "the woman", "the boy", "the girl", "the dog", "the cat", "the apple"]
  },

  "Dutch" => {
    front: ["de man", "de vrouw", "de jongen", "het meisje", "de hond", "de kat", "de appel"],
    back: ["the man", "the woman", "the boy", "the girl", "the dog", "the cat", "the apple"]
  },

  "Russian" => {
    front: ["человек", "женщина", "мальчик", "девушка", "собака", "Кот", "яблоко"],
    back: ["the man", "the woman", "the boy", "the girl", "the dog", "the cat", "the apple"]
  }
}

def add_admin(admin)
  unless User.find_by(name: admin)
    User.create!(name: admin, email: "#{admin}@fishcards.com", password: 'super_secret', password_confirmation: 'super_secret', admin: true)
  end
end

def add_users(users)
  users.each do |name|
    unless User.find_by(name: name)
      User.create!(name: name, email: "#{name}@example.com", password: 'secret', password_confirmation: 'secret')
    end
  end
end

def add_languages(languages)
  admin = User.find_by(email: "admin@fishcards.com")

  languages.keys.each do |name|
    unless Language.find_by(name: name)
      language = admin.languages.create(name: name)
      add_flashcards(languages, language, admin)
    end
  end
end

def add_flashcards(languages, language, admin)
  number_of_flashcards = languages[language.name][:front].count
  number_of_flashcards.times do |n|
    front = languages[language.name][:front][n]
    back = languages[language.name][:back][n]
    language.flashcards.create!(front: front, back: back, user_id: admin.id )
  end
end

add_admin(admin)
add_users(users)
add_languages(languages)
