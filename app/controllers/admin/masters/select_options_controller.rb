class Admin::Masters::SelectOptionsController < ApplicationController
    layout proc{ |c| ['show','new', 'create', 'edit'].include?(c.action_name)? 'admin_single_column' : 'admin'}

  def index
  # @type = params[:type]
  	@search = SelectOption.new_search(params[:search])
  	@search.conditions.type_like = params[:type]
    @search.per_page = 20
    @options = @search.all
    respond_to do |format|
       format.html
       format.js {
                      render :update do |page|
                        page.replace_html 'select_option_list', :partial => 'select_option_list'
                      end
                 }
    end

  end

  def show
  	@option = SelectOption.find(params[:id])

 	end

  def edit
  	@option = SelectOption.find(params[:id])
 	end

  def new
    @option = SelectOption.factory(params[:type])
  end

  def create
    @option = SelectOption.factory(params[:type], params[:option])
    if @option.save
      flash[:notice] = "#{params[:type]} was successfully created."
      redirect_to(admin_masters_select_options_url(:type => params[:type]))
    else
      render :action => "new"
    end
  end

  def update
    puts "ppppppppppppppppppppppppppp"
  	@option = SelectOption.find(params[:id])
  	if @option.update_attributes(params[:option])
  	  puts "zzzzzzzzzzzzzzzzzzzzzzz"
      flash[:notice] = 'Option was successfully updated.'
      redirect_to(admin_masters_select_options_path(:type => @option.type))
    else
      render :action => "edit"
   end
	end

  def destroy
  	select_option = SelectOption.find(params[:id]).destroy
  	redirect_to(admin_masters_select_options_url(:type => params[:type]))
  end

end

