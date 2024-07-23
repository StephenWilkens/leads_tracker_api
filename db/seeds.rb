require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'lead_seeds.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
csv.each do |row|
  c = Customer.new
  c.name = row['Name']
  if row['Street Address'] != nil
    if row['Street Address'].split(',')[0] != nil
      c.address = row['Street Address'].split(',')[0]
    else
      c.address = ""
    end
    if row['Street Address'].split(',')[1] != nil
      c.city = row['Street Address'].split(",")[1]
    else
      c.city = ""
    end
    if row['Street Address'].split(",")[2] != nil
      if row['Street Address'].split(",")[2].strip.split(" ")[0] != nil
        c.state = row['Street Address'].split(",")[2].strip.split(" ")[0]
      else
        c.state = ""
      end
      if row['Street Address'].split(",")[2].strip.split(" ")[1] != nil
        c.zip_code = row['Street Address'].split(",")[2].strip.split(" ")[1]
      else
        c.zip_code = ""
      end
    end
  else
    c.address = ""
    c.city = ""
    c.state = ""
    c.zip_code = ""
  end
  c.county = row['County']
  c.point_of_contact = row['Contact']
  c.contact_information = row['Contact Info']
  if row['Last Check-in'] != nil

    c.last_check_in = Date.strptime(row['Last Check-in'], '%m/%d/%Y')
  else
    c.last_check_in = ""
  end
  if row['Next Check-in'] != nil

    c.next_check_in = Date.strptime(row['Next Check-in'], '%m/%d/%Y')
  else
    c.next_check_in = ""
  end
  c.notes = row['Notes']
  c.interest_level = row['Interest']
  c.liquor_store = row['Liquor Store']
  c.bar = row['Bar']
  c.save
  puts "#{c.name} saved"
end

puts "There are now #{Customer.count} rows in the customers table"
