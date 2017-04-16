class Admin::JobsController < ApplicationController
before_action :authenticate_user!
before_action :require_is_admin
layout "admin"
def index
  @jobs=Job.all
end
def new
  @job=Job.new
end
def edit
  @job=Job.find(params[:id])
end
def show
  @job=Job.find(params[:id])
end
def create
  @job=Job.new(job_params)
  if @job.save
    redirect_to admin_jobs_path
  else
    render :new
  end
end
def update
  @job=Job.find(params[:id])
  if @job.update(job_params)
    redirect_to admin_jobs_path
  else
    render :edit
  end
end
def destroy
  @job=Job.find(params[:id])
  @job.destroy
  flash[:warning]="Job deleted!"
  redirect_to admin_jobs_path
end

def publish
  @job=Job.find(params[:id])
    @job.publish!
    flash[:notice]="该职位发布成功！"
    redirect_to :back
end

def hide
    @job=Job.find(params[:id])
    @job.hide!
    flash[:warning]="该职位已经隐藏！"
    redirect_to :back

end
private

def job_params
  params.require(:job).permit(:title,:description,:wage_upper_bound,:wage_down_bound,:contact_email,:is_hidden)
end
end
