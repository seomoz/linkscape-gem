require "linkscape/resource"

##
# Model a Linkscape Metadata resource.
# 
# @author Chris (chris@urbaninfluence.com)
class Linkscape::Metadata < Linkscape::Resource
  # The API path
  self.collection_name = "metadata"

  ##
  # Get the last index update
  #
  # @return [Fixnum] When the index was last updated.
  def self.last_update
    self.find('last_update').try(:last_update)
  end
  
  ##
  # Get the next index update
  #
  # @return [Fixnum] When the index will be updated next.
  def self.next_update
    self.find('next_update').try(:next_update)
  end

  ##
  # Default list of columns for the metadata resource.
  #
  # @return [Array] An array of columns to fetch from the remote API.
  def self.get_cols
    [:last_update, :next_update]
  end
  
  def self.element_path(id, prefix_options = {}, query_options = nil)
    Linkscape.wrap_errors do
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}/#{URI.escape id.to_s}.#{format.extension}#{query_string(query_options)}"
    end
  end
end

