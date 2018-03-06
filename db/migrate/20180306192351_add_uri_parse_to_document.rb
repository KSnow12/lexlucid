class AddUriParseToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :uri_host, :text
    add_column :documents, :uri_path, :text
    add_column :documents, :uri_query, :text
    add_column :documents, :uri_fragment, :text

    # sets up existing docs to have the correct
    # uri parses.
    Document.all.each do |document|
      document.send(:record_parsed_uri) if document.url.present?
      if !document.save
        puts "Document #{document.id} (#{document.name}) could not be saved: #{document.errors.full_messages.join(', ')}"
      end
    end
  end
end
