class ProjectsController < ApplicationController

before_filter :authenticate_user!


  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end


  def all

    if !current_user.is_admin?
      redirect_to home_path()
      return
    end
    
    @projects = Project.all()

    respond_to do |format|
      format.html { render 'index'}
      format.xml  { render :xml => @projects }
    end
  end


  # GET /projects/1
  # GET /projects/1.xml
  def show
    if Project.exists?(params[:id])
      @project = Project.find(params[:id])
      @tasks = Task.find_all_by_project_id(@project.id)
    else
      redirect_to home_path()
      return
    end

    respond_to do |format|
      format.html { render 'edit'}
      #format.html { redirect_to edit_project_path(@project)} # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    if Project.exists?(params[:id])
      @project = Project.find(params[:id])
      @tasks = Task.find_all_by_project_id(@project.id)
    else
      redirect_to home_path()
      return
    end


  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id;

    respond_to do |format|
      if @project.save
        format.html { redirect_to edit_project_path(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to projects_path() }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
