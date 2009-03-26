class SelectOptionsController < ApplicationController
 layout 'pms'

  def index
    @options = params[:type].constantize.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @options }
    end
  end

  def new
    @option = SelectOption.factory(params[:type])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @department }
    end
  end

  def create
    @option = SelectOption.factory(params[:type], params[:option])

    respond_to do |format|
      if @option.save
        flash[:notice] = "#{params[:type]} was successfully created."
        format.html { redirect_to(select_options_path(:type => params[:type])) }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
