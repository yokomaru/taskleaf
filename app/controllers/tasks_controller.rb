class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).recent
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

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      logger.debug "task: #{@task.attributes.inspect}"
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しまし〜た"
    else
      render :new
    end
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しまし〜た"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しまし〜た"
  end

  def task_logger
    @task_logger ||= Logger.new('log/task.log', 'daily')
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
