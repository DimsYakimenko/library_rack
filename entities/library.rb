# frozen_string_literal: true

class Library
  include Storage

  attr_reader :authors, :books, :readers, :orders

  def initialize
    @authors = read_yaml('authors')
    @books = read_yaml('books')
    @readers = read_yaml('readers')
    @orders = read_yaml('orders')
  end

  def add(object)
    case object
    when Author
      @authors << object
    when Book
      @books << object
    when Reader
      @readers << object
    when Order
      @orders << object
    end
  end

  def save
    save_to_yaml(@authors)
    save_to_yaml(@books)
    save_to_yaml(@readers)
    save_to_yaml(@orders)
  end

  def most_popular_books(amount = 1)
    orders.group_by do |order|
      order.book.title
    end.transform_values(&:size).sort_by { |_key, value| value }.reverse.to_h.keys.first(amount)
  end

  def top_reader(amount = 1)
    orders.group_by do |order|
      order.reader.name
    end.transform_values(&:size).sort_by { |_key, value| value }.reverse.to_h.keys.first(amount)
  end

  def number_of_readers_of_the_most_popular_books(_amount = 3)
    mpb = most_popular_books(amount = 1)
    orders.select { |o| mpb.include?(o.book.title) }.map { |order| order.reader.email }.uniq.count
  end
end
