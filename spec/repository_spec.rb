require_relative "#{__dir__}/../lib/repository.rb"

describe 'Repository' do
  it '`repository.rb` file should exist' do
    expect(File.exists?("#{__dir__}/../lib/repository.rb")).to be(true)
  end

  it '`Repository` class should be defined' do
    expect(Object.const_defined?('Repository')).to be(true)
  end

  let(:repository) { Repository.new("#{__dir__}/posts.csv") }

  let(:posts) do
    [
      [ 'path-1', 'Title 1', 'Content 1', 'Author 1', false ],
      [ 'path-2', 'Title 2', 'Content 2', 'Author 2', false ],
      [ 'path-3', 'Title 3', 'Content 3', 'Author 3', false ]
    ]
  end

  describe '#initialize' do
    it 'should load existing posts from spec/posts.csv' do
      expect(repository.all.length).to eq posts.length
    end
  end

  describe '#all' do
    it "should give access to all posts" do
      expect(repository).to respond_to :all
      expect(repository.all).to be_a Array
    end

    it 'should return array of Post instances' do
      first_post = repository.all.first
      expect(first_post).to be_instance_of(Post), lambda { "Repository should store Post instances, not #{first_post.class}" }
    end
  end

  describe '#add' do
    it 'should store the new post in CSV' do
      size_before = repository.all.length
      repository.add(Post.new())

      # Reload from CSV
      new_repository = Repository.new("#{__dir__}/posts.csv")
      expect(new_repository.all.length).to eq (size_before + 1)

      # Rewrite CSV file
      CSV.open("#{__dir__}/posts.csv", 'wb') do |csv|
        posts.each do |post|
          csv << post
        end
      end
    end
  end

  describe '#find' do
    it 'should retrieve a post from the repository' do
      expect(repository.find(1)).to be_instance_of(Post)
    end
  end

  describe '#mark_as_read' do
    it 'should change the read property for a post' do
      repository.mark_as_read(0)
      first_post = repository.all.first
      expect(first_post.read?).to eq (true)

      # Rewrite CSV file
      CSV.open("#{__dir__}/posts.csv", 'wb') do |csv|
        posts.each do |post|
          csv << post
        end
      end
    end
  end
end
