class Pet

  attr_reader :name, :type, :hair_cut, :washed, :nails_trimmed

  def initialize(info)
    @name = info[:name]
    @type = info[:type]
    @fed = false
    @hair_cut = false
    @washed = false
    @nails_trimmed = false
  end

  def fed?
    @fed
  end

  def feed
    @fed = true
  end

  def get_hair_cut
    @hair_cut = true
  end

  def get_bath
    @washed = true
  end

  def get_nails_trimmed
    @nails_trimmed = true
  end
end
