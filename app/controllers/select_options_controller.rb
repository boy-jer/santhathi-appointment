class SelectOptionsController < ApplicationController
 layout 'pms'

  def index
  #  @type = params[:type]
  	@search = SelectOption.new_search(params[:search])
  	@search.conditions.type_like = params[:type]
    @search.per_page = 20
    @options = @search.all
    respond_to do |format|
      format.html # index.html.erb
       format.js {
                      render :update do |page|
                        page.replace_html 'select_option_list', :partial => 'select_option_list'
                      end
                 }
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

  def destroy
  	select_option = SelectOption.find(params[:id]).destroy
  	 redirect_to(select_options_path(:type => params[:type]))
  end

end
