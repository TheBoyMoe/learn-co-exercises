require 'rails_helper'

RSpec.describe PostsController, type: :controller do

	# set in rails_helper.rb
	# @category = Category.create(name: 'My Category')
	# @post = @category.posts.create(title: 'My Post', description: 'My post desc')

	describe "GET #show" do
		before(:each){
			get :show, id: @post
		}

		it "returns HTTP success" do
			expect(response).to have_http_status(:success)
		end

		it 'renders the show template' do
			expect(response).to render_template(:show)
		end

		it 'fetches a post to be displayed' do
			expect(assigns(:post)).to be_a(Post)
		end

	end


	describe "GET #edit" do
		before(:each){
			get :edit, id: @post
		}
		it "returns HTTP success" do
			expect(response).to have_http_status(:success)
		end

		it 'renders the edit form' do
			expect(response).to render_template(:edit)
		end

		it 'fetches a post for editing' do
			expect(assigns(:post)).to be_a(Post)
		end

	end


	describe "GET #index" do
		before(:each){
			get :index
		}

		it 'returns HTTP success' do
			expect(response).to have_http_status(:success)
		end

		it 'lists all posts' do
			expect(assigns(:posts)).to include(@post)
		end
	end


	describe "POST #create" do

		it 'creates a new post record' do
			expect{
				post :create, {post: {title: 'new post', description: 'more content'}}
			}.to change(Post, :count).by(1)
		end

		it 'redirects to the show template displaying the post' do
			post :create, {post: {title: 'new post', description: 'more content'}}
			expect(response).to redirect_to(post_path(Post.last))
		end
	end


	describe "PATCH #update" do
		let(:new_attributes){{title: 'new title'}}
		before(:each){
			patch :update, {id: @post.id, post: new_attributes}
		}

		it 'updates the post' do
			@post.reload
			expect(@post.title).to eq('new title')
		end

		it 'redirects to the show template displaying the post' do
			expect(response).to redirect_to(post_path(Post.last))
		end
	end


	describe "DELETE #destroy" do

		it 'deletes the record from the database' do
			expect{
				delete :destroy, {id: @post.id}
			}.to change(Post, :count).by(-1)
		end

		it 'redirects the user to the index page' do
			delete :destroy, {id: @post.id}
			expect(response).to redirect_to(posts_path)
		end
	end

end
