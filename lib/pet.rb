class Pet

  attr_reader :name, :type

  def initialize(info)
    @name = info[:name]
    @type = info[:type]
    @fed = false
  end

  def fed?
    @fed
  end

  def feed
    @fed = true
  end
end
