require 'yaml'

filename = 'birthdays.txt'

birthday_hashes = {
  'Nathaniel Nasarow' => 'Aug 26, 1982',
  'Jeff Roges' => 'Sep 11, 2001',
  'Christopher Alexander' => 'Mar 29, 1957',
  'Christopher Plummer' => 'Dec 13, 1927',
  'Christopher Pine' => 'Aug 3 1976',
  'The King of Spain' => 'Jan 5, 1938'
}

def yaml_save object, filename
  File.open filename, 'w' do |f|
    f.write(object.to_yaml)
  end
end

def yaml_load file
  yaml_string = File.read file
  puts "Welcome to the birthday search"
  return YAML::load yaml_string
  
end

yaml_save(birthday_hashes, filename)
read_dates = yaml_load filename

def ask_name (filename)
  
  name_index = Array.new
  counter = 0
  birth_dates = filename
  key_names = birth_dates.keys
  
  puts "Type in the first name of the person you want to find"
  query = gets.chomp

  key_names.each_with_index do |a, index|
    if a[0...query.length] == query
      counter += 1
      name_index << index
    end
  end
  return find_name(name_index, counter, birth_dates, key_names, query)
end

def find_name (names, counter, birthdates, name_keys, query)
  if counter > 1
    puts "There are several #{query}s in the database."
    return multiple_returns(name_keys, names, birthdates)
  else
    puts birthdates[name_keys[names[0]]]
  end
end

def multiple_returns (names, name_keys, birthdates) 
  name_keys.each {|x| puts names[x]}
  puts "Type in the last name of the subject you wish to inspect: "
  last_name = gets.chomp
  names.each do |a|
    if a[-(last_name.length).to_i..-1] == last_name
      return birthdates[a].to_s
    end
  end
end


ask_name (read_dates)