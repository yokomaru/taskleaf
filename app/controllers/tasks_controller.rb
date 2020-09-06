class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page])
    # TODO:下記エラー解消
    # bin/rails g kaminari:views bootstrap4
    # Could not find generator 'kaminari:views'.
    # Run `rails generate --help` for more options
    respond_to do |format|
      format.html
      format.csv {send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
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

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しまし〜た"
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end
end
