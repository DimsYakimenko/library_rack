# frozen_string_literal: true

module Storage
  def save_to_yaml(collection)
    file_name = "./data/#{collection.first.class.to_s.downcase}s.yml"
    File.open(file_name, 'w') { |file| file.write(collection.to_yaml) }
  end

  def read_yaml(collection)
    YAML.load_file("./data/#{collection}.yml", permitted_classes: [Book, Author, Order, Reader, Date])
  rescue Errno::ENOENT
    File.open("./data/#{collection}.yml", 'w') { |file| file.write([].to_yaml) }
    retry
  end
end
