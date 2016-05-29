class Array
  def find_and_replace!(s, r)
    self[index(s)] = r if index(s)
  end
end