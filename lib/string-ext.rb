class String
  def template v={}, delim=':'
    v = v.stringify_keys
    re = Regexp.new("#{delim}([a-zA-Z][a-zA-Z0-9_]*)#{delim}")
    self.gsub(re) {|m| v[$1].to_s }
  end
end
