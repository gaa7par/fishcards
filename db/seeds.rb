admin = "admin@fishcards.com"
users = %w(alpha@fishcards.com bravo@fishcards.com charlie@fishcards.com)

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
  unless User.find_by(email: admin)
    User.create!(email: admin, password: 'super_secret', password_confirmation: 'super_secret', admin?: true)
  end
end

def add_users(users)
  users.each do |email|
    unless User.find_by(email: email)
      User.create!(email: email, password: 'secret', password_confirmation: 'secret')
    end
  end
end

def add_languages(languages)
  languages.keys.each do |name|
    unless Language.find_by(name: name)
      language = Language.create(name: name)
      add_flashcards(languages, language)
    end
  end
end

def add_flashcards(languages, language)
  number_of_flashcards = languages[language.name][:front].count
  number_of_flashcards.times do |n|
    front = languages[language.name][:front][n]
    back = languages[language.name][:back][n]
    language.flashcards.create!(front: front, back: back)
  end
end

add_admin(admin)
add_users(users)
add_languages(languages)
