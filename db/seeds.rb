def create_survey(content, author, end_date)
  survey = Survey.create(
    content:,
    author:,
    end_date:
  )

  survey.save(validate: false)

  survey
end

def create_answers(survey, answers)
  answers.map do |answer_content|
    survey.answers.create!(content: answer_content)
  end
end

def create_user(email, password)
  User.create!(
    email:,
    password:,
    password_confirmation: password,
    admin: false
  )
end

def create_user_answer(user, answer)
  AuthorAnswer.create!(author: user, answer:)
end

admin = User.find_or_initialize_by(email: 'admin@example.com')
admin.password = 'password123'
admin.password_confirmation = 'password123'
admin.admin = true

if admin.save
  puts "User #{admin.email} created successfully."
else
  puts "Error creating admin: #{admin.errors.full_messages.join(', ')}"
end

current_time = Time.current

# Active surveys (end date in the future)
survey1 = create_survey('What is your favorite Simpson character?', admin, current_time + 10.days)
answers1 = create_answers(survey1, [
                            'Homer Simpson', 'Marge Simpson', 'Bart Simpson', 'Lisa Simpson', 'Maggie Simpson',
                            'Mr. Burns', 'Ned Flanders', 'Krusty the Clown'
                          ])

survey2 = create_survey('What is the best Simpsons episode ever?', admin, current_time + 15.days)
answers2 = create_answers(survey2, [
                            'Marge vs. the Monorail', 'Last Exit to Springfield', 'Cape Feare',
                            'Treehouse of Horror V', 'Who Shot Mr. Burns?', 'Homer at the Bat',
                            'You Only Move Twice', 'Lisa the Vegetarian'
                          ])

survey3 = create_survey('Who is the most underrated Simpson character?', admin, current_time + 20.days)
answers3 = create_answers(survey3, [
                            'Lenny Leonard', 'Carl Carlson', 'Moe Szyslak', 'Ralph Wiggum', 'Milhouse Van Houten',
                            'Barney Gumble', 'Chief Wiggum', 'Sideshow Mel'
                          ])

# Inactive surveys (end date in the past)
survey4 = create_survey('Which Simpson character do you relate to the most?', admin, current_time - 10.days)
answers4 = create_answers(survey4, [
                            'Homer Simpson', 'Marge Simpson', 'Bart Simpson', 'Lisa Simpson', 'Maggie Simpson',
                            'Ned Flanders', 'Apu Nahasapeemapetilon', 'Selma Bouvier'
                          ])

survey5 = create_survey("What's your favorite quote from The Simpsons?", admin, current_time - 15.days)
answers5 = create_answers(survey5, [
                            'D\'oh!', 'Eat my shorts!', 'Excellent.', 'Ay, caramba!', 'Ha-ha!',
                            'Worst. Episode. Ever.', 'I\'m Bart Simpson, who the hell are you?', 'Mmm... donuts.'
                          ])

survey6 = create_survey('What is your favorite Simpsons catchphrase?', admin, current_time - 20.days)
answers6 = create_answers(survey6, [
                            'D\'oh!', 'Eat my shorts!', 'Excellent.', 'Ay, caramba!', 'Ha-ha!',
                            'Worst. Episode. Ever.', 'I\'m Bart Simpson, who the hell are you?', 'Mmm... donuts.'
                          ])

puts 'Surveys and answers created successfully!'

# List of Simpson characters for user emails
character_names = [
  'homer.simpson', 'marge.simpson', 'bart.simpson', 'lisa.simpson', 'maggie.simpson',
  'ned.flanders', 'apu.nahasapeemapetilon', 'milhouse.van.houten', 'krusty.the.clown',
  'moe.szyslak', 'barney.gumble', 'ralph.wiggum', 'nelson.muntz', 'sideshow.bob', 'chief.wiggum'
]

# Create 15 non-admin users
users = character_names.map do |name|
  email = "#{name}@example.com"
  password = 'password123'
  user = create_user(email, password)

  if user.save
    puts "User #{user.email} created successfully."
  else
    puts "Error creating user: #{user.errors.full_messages.join(', ')}"
  end

  user
end

# Active surveys
create_user_answer(users[0], answers1[0])
create_user_answer(users[1], answers1[0])
create_user_answer(users[2], answers1[0])
create_user_answer(users[3], answers1[2])
create_user_answer(users[4], answers1[2])
create_user_answer(users[5], answers1[5])
create_user_answer(users[6], answers1[6])
create_user_answer(users[7], answers1[7])

create_user_answer(users[8], answers2[0])
create_user_answer(users[9], answers2[1])
create_user_answer(users[10], answers2[2])
create_user_answer(users[11], answers2[3])
create_user_answer(users[12], answers2[4])
create_user_answer(users[13], answers2[5])
create_user_answer(users[14], answers2[6])

# Inactive surveys
create_user_answer(users[0], answers3[0])
create_user_answer(users[1], answers3[1])
create_user_answer(users[2], answers3[2])
create_user_answer(users[3], answers3[3])
create_user_answer(users[4], answers3[4])
create_user_answer(users[5], answers3[5])
create_user_answer(users[6], answers3[6])
create_user_answer(users[7], answers3[7])

create_user_answer(users[8], answers4[0])
create_user_answer(users[9], answers4[1])
create_user_answer(users[10], answers4[2])
create_user_answer(users[11], answers4[3])
create_user_answer(users[12], answers4[4])
create_user_answer(users[13], answers4[5])
create_user_answer(users[14], answers4[6])

create_user_answer(users[0], answers5[0])
create_user_answer(users[1], answers5[1])
create_user_answer(users[2], answers5[2])
create_user_answer(users[3], answers5[3])
create_user_answer(users[4], answers5[4])
create_user_answer(users[5], answers5[5])
create_user_answer(users[6], answers5[6])
create_user_answer(users[7], answers5[7])

create_user_answer(users[8], answers6[0])
create_user_answer(users[9], answers6[1])
create_user_answer(users[10], answers6[2])
create_user_answer(users[11], answers6[3])
create_user_answer(users[12], answers6[4])
create_user_answer(users[13], answers6[5])
create_user_answer(users[14], answers6[6])

puts 'Users answered surveys successfully!'
