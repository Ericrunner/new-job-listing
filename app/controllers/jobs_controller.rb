class JobsController < ApplicationController
before_action :authenticate_user!, only: [:new,:edit,:create,:update,:destroy]
def index
  @jobs=case params[:order]
       when "by_upper_bound"
         Job.where(is_hidden:false).order("wage_upper_bound DESC")
       when "by_lower_bound"
         Job.where(is_hidden:false).order("wage_down_bound DESC")
       when "frontend"
         Job.where(job_sorting:"前端开发")
       when "backend"
         Job.where(job_sorting:"后端开发")
       when "fullstack"
         Job.where(job_sorting:"全栈开发")
       else
         Job.where(is_hidden:false).order("created_at DESC")
       end
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
    redirect_to jobs_path
  else
    render :new
  end
end
def update
  @job=Job.find(params[:id])
  if @job.update(job_params)
    redirect_to jobs_path
  else
    render :edit
  end
end
def destroy
  @job=Job.find(params[:id])
  @job.destroy
  redirect_to jobs_path
  flash[:warning]="Job deleted!"
end

private

def job_params
  params.require(:job).permit(:title,:description)
end
end
