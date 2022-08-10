module Middlewares
  class Racker
    def initialize
      @library = Library.new
    end

    def call(env)
      case env['PATH_INFO']
      when '/authors' then build_authors_page
      when '/books' then build_books_page
      when '/readers' then build_readers_page
      when '/orders' then build_orders_page
    end



    def build_authors_page
      authors = @library.authors.map { |author| author.name }.uniq.join('<br>')
      response(authors)
    end

    def build_books_page
      books = @library.books.map { |book| book.title }.uniq.join('<br>')
      response(books)
    end

    def build_readers_page
      readers = @library.readers.map { |reader| reader.email }.uniq.join('<br>')
      response(readers)
    end

    def build_orders_page
      orders = @library.orders.map { |order| decorate_order(order) }.uniq.join('<br>')
      response(orders)
    end

    def decorate_order(order)
      "#{order.book.author.name} - #{order.book.title}. #{order.date}. #{order.reader.email}"
    end

    def response(body)
      [200, {'Content-Type' => 'text/html'}, [body]]
    end
  end
end
end
