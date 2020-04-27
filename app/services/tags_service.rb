class TagsService
  def initialize(name:, source:)
    @tag = Tag.find_or_create_by(name: name)
    @source = source
  end

  def execute
  	return @tag if tag_exist? 

    @source.tags << @tag
    @source.save

    @tag
  end

  private

  def tag_exist?
  	@source.tags.find_by(name: @tag.name).present?
  end
end
