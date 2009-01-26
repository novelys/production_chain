class Object
  # This one is already in Rails edge and will be in Rails 2.2 so... very useful when testing for presence of parameters...
  def present?
    !blank?
  end
end
