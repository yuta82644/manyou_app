class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc)

    if params[:sort_expired]
      @tasks = @tasks.order(end_time: :desc)
      # elsif params[:sort_created]
      #   @tasks = Task.order(created_at: :desc)
    end

    #あいまい検索タイトル
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      @tasks = @tasks.title_search(title) if title.present?
      @tasks = @tasks.status_search(status) if status.present?
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :end_time, :status)
  end
end
