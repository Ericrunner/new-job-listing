class JobsController < ApplicationController
before_action :authenticate_user!, only: [:new,:edit,:create,:update,:destroy]
before_action :validate_search_key, only:[:search]
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

def search
  if @query_string.present?
    search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
    @jobs = search_result.recent.paginate(:page => params[:page], :per_page => 5 )
  end
end
private

def job_params
  params.require(:job).permit(:title,:description,:wage_upper_bound,:wage_down_bound,:contact_email,:is_hidden,:job_sorting,:company,:city)
end

protected
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "")
    if params[:q].present?
      @search_criteria =  {
        title_or_company_or_city_cont: @query_string
      }
    end
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end
end
