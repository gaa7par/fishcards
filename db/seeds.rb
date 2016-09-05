users = %w(alpha@fishcards.com bravo@fishcards.com charlie@fishcards.com)

data = {
  "Spanish" => {
    "el hombre" => "the man",
    "la mujer" => "the woman",
    "el niño" => "the boy",
    "la niña" => "the girl",
    "el perro" => "the dog",
    "el gato" => "the cat",
    "la manzana" => "the apple"
  },

  "French" => {
    "l'homme" => "the man",
    "la femme" => "the woman",
    "le garçon" => "the boy",
    "la fille" => "the girl",
    "le chien" => "the dog",
    "le chat" => "the cat",
    "la pomme" => "the apple"
  },

  "German" => {
    "der Mann" => "the man",
    "die Frau" => "the woman",
    "der Junge" => "the boy",
    "das Mädchen" => "the girl",
    "der Hund" => "the dog",
    "die Katze" => "the cat",
    "das Apfel" => "the apple"
  },

  "Italian" => {
    "l'oumo" => "the man",
    "la donna" => "the woman",
    "il ragazzo" => "the boy",
    "la ragazza" => "the girl",
    "il cane" => "the dog",
    "il gatto" => "the cat",
    "la mela" => "the apple"
  },

  "Portuguese" => {
    "o homem" => "the man",
    "a mulher" => "the woman",
    "o menino" => "the boy",
    "a menina" => "the girl",
    "o cachorro" => "the dog",
    "o gato" => "the cat",
    "a maçã" => "the apple"
  },

  "Dutch" => {
    "de man" => "the man",
    "de vrouw" => "the woman",
    "de jongen" => "the boy",
    "het meisje" => "the girl",
    "de hond" => "the dog",
    "de kat" => "the cat",
    "de appel" => "the apple"
  },

  "Russian" => {
    "человек" => "the man",
    "женщина" => "the woman",
    "мальчик" => "the boy",
    "девушка" => "the girl",
    "собака" => "the dog",
    "Кот" => "the cat",
    "яблоко" => "the apple"
  }
}

languages = data.keys
flashcards = data.values

def add_users(users)
  users.each do |user|
    unless User.find_by(email: user)
      User.create!(email: user, password: 'secret', password_confirmation: 'secret')
    end
  end
end

def add_languages(languages, flashcards)
  languages.each do |name|
    unless Language.find_by(name: name)
      language = Language.create(name: name)
      add_flashcards(language, flashcards)
    end
  end
end

def add_flashcards(language, flashcards)
  language.flashcards.create!(front: front, back: back)
end

add_users(users)
add_languages(languages)
