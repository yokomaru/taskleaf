class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def show
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しまし〜た"
    else
      render :new
    end
  end

  def update
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しまし〜た"
  end

  def destroy
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しまし〜た"
  end

  private

  def set_task
    @task = current_user.tasks.find(task_params)
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
