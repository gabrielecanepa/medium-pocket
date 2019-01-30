require_relative "#{__dir__}/../lib/post.rb"

describe 'Post' do
  it '`post.rb` file should exist' do
    expect(File.exists?("#{__dir__}/../lib/post.rb")).to be(true)
  end

  it '`Post` class should be defined' do
    expect(Object.const_defined?('Post')).to be(true)
  end

  let(:post) { Post.new(
    path: 'path-to-the-post',
    title: 'Post title',
    content: 'Post content',
    author: 'Post author'
  )}

  describe '#path' do
    it 'should return the path of the post' do
      expect(post).to respond_to :path
    end
  end

  describe '#title' do
    it 'should return the title of the post' do
      expect(post).to respond_to :title
    end
  end

  describe '#author' do
    it 'should return the author of the post' do
      expect(post).to respond_to :author
    end
  end

  describe '#content' do
    it 'should return the content of the post' do
      expect(post).to respond_to :content
    end
  end

  describe '#initialize' do
    it 'should create a post with a list of attributes' do
      expect(post.path).to eq 'path-to-the-post'
      expect(post.title).to eq 'Post title'
      expect(post.content).to eq 'Post content'
      expect(post.author).to eq 'Post author'
      expect(post.read?).to eq false
    end
  end

  describe '#read?' do
    it 'should return a boolean representing the state of the article' do
      expect(post).to respond_to :read?
    end
  end

  describe '#mark_as_read!' do
    it 'should change the read property for a post' do
      post.mark_as_read!
      expect(post.read?).to eq(true)
    end
  end
end
