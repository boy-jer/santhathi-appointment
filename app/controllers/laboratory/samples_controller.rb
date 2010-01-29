class Laboratory::SamplesController < ApplicationController
layout proc{ |c| ['show','new', 'create','edit'].include?(c.action_name)? 'laboratory_single_column' : 'laboratory'}
  def index
    @search = Sample.new_search(params[:search])
    @search.per_page ||= 15
    @samples  = @search.all
    respond_to do |format|
                  format.html
                  format.js { render :update do |page|
                                page.replace_html 'sample_list', :partial => 'samples_list'
                              end
                            }
    end
  end

  def show
    @sample = Sample.find(params[:id])
    render :layout => false
  end

  def new
    @sample = Sample.new
  end

  def edit
    @sample = Sample.find(params[:id])
  end

  def create
    @sample = Sample.new(params[:sample])
    if @sample.save
      flash[:notice] = 'Sample was successfully created.'
      redirect_to(laboratory_samples_url)
    else
      render :action => "new"
    end
  end

  def update
    @sample = Sample.find(params[:id])
    if @sample.update_attributes(params[:sample])
      flash[:notice] = 'Sample was successfully updated.'
      redirect_to(laboratory_samples_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy
    redirect_to(laboratory_samples_url)
  end
end

