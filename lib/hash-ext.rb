# Copied from ActiveSupport, included if we don't already have it

class Hash
  # Return a new hash with all keys converted to symbols.
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end
  def symbolize_keys!
    self.replace(self.symbolize_keys)
  end
  # Return a new hash with all keys converted to strings.
  def stringify_keys
    inject({}) do |options, (key, value)|
      options[(key.to_s rescue key) || key] = value
      options
    end
  end
  def stringify_keys!
    self.replace(self.stringify_keys)
  end
end
