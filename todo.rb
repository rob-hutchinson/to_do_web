require "pry"
require "./db/setup"
require "./lib/all"
require "httparty"
require "thor"

class Todo < Thor
  include HTTParty
  base_uri "http://localhost:4567"

  desc "add ITEM LIST USER", "Adds [ITEM] to [USER]'s [LIST]"
  def add item, list, user
    self.class.post("/lists/#{list}", body: {item: item}, headers: {"Authorization" => user})
    puts "OK"
  end

  desc "due ITEM DUE_DATE USER", "Marks item with [ITEM] ID with a [DUE DATE]"
  def due item_id, due_date, user
    puts self.class.patch("/items/#{item_id}", body: {due_date: due_date}, headers: {"Authorization" => user})
  end

  desc "done ID USER", "Marks the item with the given [ID] as done"
  def done item_id, user
    puts self.class.patch("/items/#{item_id}", body: {done: "true"}, headers: {"Authorization" => user})
  end

  desc "next USER", "Returns a random uncompleted item from a [USER]"
  def next user 
    puts self.class.get("/next", headers: {"Authorization" => user})
  end

  desc "search STRING", "Searches items for [STRING] and returns it"
  def search string, user
    puts self.class.get("/search", body: {search: string}, headers: {"Authorization" => user})
  end

  desc "list [ALL/LIST] USER", "Prints [USER]'s items on a specific [LIST] or [ALL] of that users items or a [USER]'s list names"
  def list arg = nil, user
    puts self.class.get("/lists/#{arg}", headers: {"Authorization" => user})
  end

  desc "items USER", "Prints all of a [USER]'s unfinished items"
  def items user
    puts self.class.get("/items", headers: {"Authorization" => user})
  end
end

Todo.start(ARGV)
