# #8 tell Ruby to load the library named entry.rb relative to address_book.rb's file path using require_relative.
require_relative 'entry'

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
end
