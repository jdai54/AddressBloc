# #1 include AddressBook using require_relative
require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # #2 display the main menu options to the command line
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    # #3 retrieve user input from the command line using gets
    selection = gets.to_i

    # #7 use a case statement operator to determine the proper response to a user's input
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      puts "Good-bye!"
      # #8 terminate the program using exit(0). 0 signals the program is exiting without an error
      exit(0)
    # #9 use an else to catch invalid user input and prompt user to retry
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  def view_all_entries
    # #14 iterate through all entries in AddressBook using each
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
    # #15 call entry_submenu to display a submenu for each entry
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    # #11 clear the screen before displaying the create entry prompts
    system "clear"
    puts "New AddressBloc Entry"
    # #12 use print to prompt the user for each Entry attribute. print works just like puts, except it doesn't add a newline
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # #13 add a new entry to address_book using add_entry to ensure that the new entry is added in the proper order
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
    # #9 get the name that the user wants to search for and store it in "name"
    print "Search by name: "
    name = gets.chomp
    # #10 call "search" on "address_book" which will return a match or nil. It will never return an empty string since import_from_csv will fail if an entry does not have a name
    match = address_book.binary_search(name)
    system "clear"
    # #11 check if search returned a match. This expression evaluates to false if search returns nil since nil evaluates to false. If search finds a match, then we call a helper method called "search_submenu" which displays a list of operations that can be performed on an Entry
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    # #1 prompt user to enter a name of a CSV file to import We get the filename fromo STDIN and call the "chomp" method which removes newlines
    print "Enter CSV file to import: "
    file_name = gets.chomp

    # #2 check to see if the file name is empty. If it is, we return the user back to the main menu by calling "main_menu"
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end
    # #3 import the specified file with import_from_csv on address_book. We then clear the screen and print the numberof entries that were read from the file. All of these commands aer wrapped in a "begin/rescue" block. "begin" will protect the program from crashing if an exception is thrown. In Ruby, if the program performs an operaton that is illegal, it will throw an exception, but the program is allowed to continue executing at the "rescue" statement
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def entry_submenu(entry)
    # #16 dispaly the submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # #17 chomp removes any trailing whitespace from the string returned by gets. This is necessary because it has to exactly match the selections
    selection = gets.chomp

    case selection
    # #18 when the user asks to see the next entry, we can do nothing and control will be returned to view_all_entries
      when "n"
    # #19 deleting and editing
      when "d"
        delete_entry(entry)
      when "e"
        edit_entry(entry)
        entry_submenu(entry)
    # #20 return user to main menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
      end
    end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    # #4 perform a series of "print" statements followed by "gets.chomp" assignment statements. Each "gets.chomp" statement gathers user input and assigns it to an appropriately named variable
    print "Updatd name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    # #5 use "!attribute.empty?" to set attributes on entry only if a valid attribute was read from the user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    # #6 print out updated entry
    puts "Updated entry:"
    puts entry
  end

  def search_submenu(entry)
    # #12 print out submenu for an entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    # #13 save the user input to "selection"
    selection = gets.chomp

    # #14 use a case statement and take a specific action based on user input. If the input does not match anything (else statement) then clear the screen and ask for input again by calling "search_submenu"
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end
end
