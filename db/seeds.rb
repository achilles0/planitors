# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

food = Category.create(name: 'Food')
travel = Category.create(name: 'Travel')
energy = Category.create(name: 'Energy')
other = Category.create(name: 'Other')

# Temporary
# energy = Category.find_by(name: 'Energy')
# level1 = Level.find_by(name: 'Recovering planet destroyer')
# level3 = Level.find_by(name: 'Neutral')

level1 = Level.create(name: 'Recovering planet destroyer', icon: 'japanese_ogre')
level2 = Level.create(name: 'Planetary novice', icon: 'seedling')
level3 = Level.create(name: 'Neutral', icon: 'recycle') # Neither good nor bad, but better than most.
level4 = Level.create(name: 'Contributor', icon: 'sunflower')
level5 = Level.create(name: 'Planitor', icon: 'earth_africa')

Mission.create(level: level1, category: food, icon: 'avocado', name: 'Din köttfria vecka', text: 'Under en vecka ska du undvika allt kött.

Ingen skinka till frukost, ingen kycklingfilé till lunch, ingen köttfärs till middag. Fisk, ägg och blodpudding är ok under detta uppdrag. Dessa räknas inte som kött.

Omkring 15% av all växthuseffekt i världen kommer av köttproduktion. [https://en.wikipedia.org/wiki/Environmental_impact_of_meat_production]', co2: 14, continuous: false, difficulty: 0.5)

Mission.create(level: level1, category: food, icon: 'eggplant', name: 'Din köttfria dag', text: 'Under 24 timmar ska du undvika allt kött.

Ingen skinka till frukost, ingen kycklingfilé till lunch, ingen köttfärs till middag. Fisk, ägg och blodpudding är ok under detta uppdrag. Dessa räknas inte som kött.

Omkring 15% av all växthuseffekt i världen kommer av köttproduktion. [https://en.wikipedia.org/wiki/Environmental_impact_of_meat_production]', co2: 2, continuous: false, difficulty: 0.1)

Mission.create(level: level1, category: food, icon: 'no_entry_sign', name: 'Din kastfria vecka', text: 'Under en vecka ska ingen mat kastas.

I Sverige slängs omkring 30% av all ätbar mat. Det ger stora miljökostnader till ingen nytta. I det här uppdraget ska vi vara 10 ggr bättre, släng max 3% av matvärdet under en vecka. Ät upp alla rester innan något nytt lagas. Planera matlagningen så att öppnade råvaror går åt till nästa rätt. Släng inget utan att smaka. Yoghurt som är 3 veckor efter bäst före datum är ofta god att äta.

https://www.youtube.com/watch?v=VGTPKKOVoz4&list=PL_eZRv1hKPjzgG_oSbA4Ya9jmSNHjqzfU', co2: 1, continuous: false, difficulty: 0.1)


Mission.create(level: level1, category: energy, icon: 'electric_plug', name: 'Byt till miljömärkt el', text: 'En av de enklaste och snabbaste åtgärderna du kan göra för miljön. Sparar dessutom co2 varje dag.', co2: 1, continuous: true, difficulty: 0.1)

Mission.create(level: level3, category: other, icon: 'feet', name: 'Mät ditt fotavtryck', text: 'Gå till den här länken: . Kom tillbaka och fyll i värdena.', co2: 0, continuous: false, difficulty: 0.1)

Mission.create(level: level3, category: other, icon: 'money_with_wings', name: 'Kompensera ditt avtryck', text: 'Medan du kämpar för att sänka dina utsläpp till en hållbar nivå kan du kompensera för ditt budgetunderskott genom att klimatkompensera.', co2: 0, continuous: false, difficulty: 2)

# Mission ideas
# Grön el
# Bättre kött (ät vilt kött)

#User.create(email: 'jonathan@imagineit.se', password: 'hurlumhej', password_confirmation: 'hurlumhej')

Newsitem.create(level: level1, icon: 'money_with_wings', name: 'Nordea divesterar från Keystone XL', text:'Nordea har efter hårda påtryckningar från klimatrörelsen till slut bestämt sig för att divestera från Keystoen XL projektet. Ett omstritt projekt att bygga en pipeline från oljesandsfälten i Kanada.')

User_interests.create(id: 1, tag_id: 1, weight: 50)