require_relative '../models/address_book'

RSpec.describe AddressBook do
  describe "attributes" do
    it "responds to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "initializes entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).to eq(0)
    end
  end

  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  describe "#remove_entry" do
      before :each do
        @book = AddressBook.new
        @book.add_entry('Jake Dai', '12345678', 'jake@dai.com')
        @book.add_entry('Joe Smith', '9876543210', 'joesmith@hello.com')
      end
      it 'does not delete entry if it does not exist' do
        expect(@book.entries.size).to eq(2)
        @book.remove_entry('Joe S', '010.012.1815', 'augusta.king@lovelace.com')
        expect(@book.entries.size).to eq(2)
      end
      it 'deletes only the passed entry' do
        expect(@book.entries.size).to eq(2)
        @book.remove_entry('Jake Dai', '12345678', 'jake@dai.com')
        expect(@book.entries.size).to eq(1)
      end
      it 'deletes correct entry' do
        expect(@book.entries.size).to eq(2)
        @book.remove_entry('Jake Dai', '12345678', 'jake@dai.com')
        @book.entries.each do |entry|
          expect(entry.name).not_to eq 'Jake Dai'
          expect(entry.phone_number).not_to eq '12345678'
          expect(entry.email).not_to eq 'jake@dai.com'
      end
    end
  end
end
