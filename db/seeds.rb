# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
endorsements = [
  {
    name: "Jane",
    lastname: "Doe",
    doctype: "nie",
    docid: "Z6263579V",
    email: "jane.doe@acme.org",
    birthdate: "1985-08-14",
    postal_code: "08001",
    activity: "Marketing",
    subscribed: true,
    hidden: false,
    featured: true,
    approved: false,
    group: false
  },
  {
    name: "Carles",
    lastname: "Muiños",
    doctype: "dni",
    docid: "04824625F",
    email: "carles.oop@acme.org",
    birthdate: "1975-03-09",
    postal_code: "08002",
    activity: "ICT",
    subscribed: false,
    hidden: false,
    featured: false,
    approved: false,
    group: false
  },
  {
    name: "Klaudia",
    lastname: "Alvarez",
    doctype: "dni",
    docid: "72415358L",
    email: "klaudia.oop@acme.org",
    birthdate: "1976-02-08",
    postal_code: "08003",
    activity: "Arts",
    subscribed: false,
    hidden: false,
    featured: true,
    approved: false,
    group: false
  },
  {
    name: "Col·lectiu 1871",
    lastname: "",
    doctype: "",
    docid: "",
    email: "c1871@acme.org",
    birthdate: "",
    postal_code: "08003",
    activity: "Investigació social",
    subscribed: true,
    hidden: false,
    featured: false,
    approved: false,
    group: true
  }
]

endorsements.each { |e| Endorsement.create! e }
