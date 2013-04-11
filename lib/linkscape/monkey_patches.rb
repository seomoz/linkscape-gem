require 'active_resource'

class ActiveResource::Base
  ##
  # Taken from ActiveResource::Base at SHA d5be36dbcfa465e42f9b35284e119aaee044b1b3. Respect
  # include_root_in_json.
  def to_json(options={})
    super(include_root_in_json ? { :root => self.class.element_name }.merge(options) : options)
  end
end
