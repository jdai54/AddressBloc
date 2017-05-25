# #8 tell Ruby to load the library named entry.rb relative to address_book.rb's file path using require_relative.
require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    # #9 create a variable to store the insertion index
    index = 0
    entries.each do |entry|
      # #10 compare name with the name of the current entry. If name lexicographically proceeds entry.name, we've found the index to insert at. Otherwise, increment index and continue comparing with the other entries
      if name < entry.name
        break
      end
      index += 1
    end
    # #11 insert a new entry into entries using the calculated index
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  #def remove_entry(name, phone_number, email)
#    entries.each do |entry|
#      entries.delete_at(entries.index(entry.name)) if name == entry.name
#    end
#  end

  def remove_entry(name, phone_number, email)
   @entries.each_with_index do |value, index|
      if value.name == name && value.phone_number == phone_number && value.email == email
        @entries.delete_at(index)
        break
      end
    end
  end
# #7 the import_from_csv method starts by reading the file using "File.read". The file will be in a CSV format. We use the CSV class to parse the file. The result of CSV.parse is an object of type CSV::Table
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # #8 We iterate over the CSV::Table object's rows. On the next line we create a hash for each row. We convert each row_hash to an "Entry" by using the add_entry method which will also add the Entry to the AddressBook's entries
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end
end
