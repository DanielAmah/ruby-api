module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                @articles = Article.order('created_at DESC');
                render json: {status: 'SUCCESS', message: 'Articles Retrieve Successfully', articles: @articles},
                status: :ok
            end

            def show
                article = Article.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Article Retrieve Successfully', article: article},
                status: :ok
            end

            def create
                article = Article.new(article_params)

                if article.save
                    render json: {status: 'SUCCESS', message: 'Saved Article', article: article},
                    status: :ok
                else
                    render json: {status: 'ERROR', message: 'Article not saved', error: article.errors},
                    status: :unprocessable_entity
                end
            end

            def destroy
                article = Article.find(params[:id]) 
                article.destroy
                render json: {status: 'SUCCESS', message: 'Delete successfully', article: article},
                status: :ok

            end

            def update
                article = Article.find(params[:id]) 
                if article.update_attributes(article_params)
                    render json: {status: 'SUCCESS', message: 'Updated article', article: article},
                    status: :ok
                else
                    render json: {status: 'ERROR', message: 'Article not updated', error: article.errors},
                    status: :unprocessable_entity
                end

            end

            private

            def article_params
                params.permit(:title, :body)
            end

        end
    end

end