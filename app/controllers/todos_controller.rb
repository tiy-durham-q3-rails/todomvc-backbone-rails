class TodosController < ApplicationController
  before_action :find_todo, except: [:index, :create]


  def index
    @todos = Todo.all
    json = Jbuilder.encode do |json|
      json.array! @todos, :id, :title, :completed, :order
    end
    render :json => json
  end

  def show
    render :json => todo_json(@json)
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render :json => todo_json(@json), :status => :created
    else
      # return some status
    end
  end

  def update
    if @todo.update(todo_params)
      render :json => todo_json(@json)
    else
      # return some status
    end
  end

  def destroy
    if @todo.destroy
      render nothing: true, status: :no_content
    else
      # return ???
    end
  end

  private

  def todo_json(todo)
    Jbuilder.encode do |json|
      json.(todo, :id, :title, :completed, :order)
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :completed, :order)
  end

  def find_todo
    @todo = Todo.find(params[:id])
  end
end
