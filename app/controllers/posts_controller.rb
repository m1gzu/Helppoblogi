class PostsController < ApplicationController
	#http_basic_authenticate_with name: "migzu", password:"1234", except: [:index, :show]
	before_action :authenticate_user!, except: [:index, :show]
	#before_filter :correct_user!, only: [:edit, :update, :show]

	def index 
		@posts =Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = current_user.posts.build
	end

	def create
		#render plain: params[:post].inspect
		#ylläoleva oli testinä postauksien tallentamista varten
		@post = current_user.posts.build(post_params)
		
		if(@post.save)
		redirect_to @post
		else 
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if(@post.update(post_params))
			redirect_to @post
		else 
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end
		

	private def post_params
		params.require(:post).permit(:title, :body)
	end	
end

