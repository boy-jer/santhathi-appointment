class Admin::ContactListsController < ApplicationController
  # GET /admin_contact_lists
  # GET /admin_contact_lists.xml
  layout 'admin_single_column'
  

  def index
     @search = ContactList.new_search(params[:search])
     @search.per_page ||= 15
     @search.order_as ||= "ASC"
     @search.order_by ||= "name"
   
   
    @contact_lists = @search.all
    
       
    respond_to do |format|
      format.html # index.html.erb
      format.js {  render :update do |page|
                           page.replace_html 'contact-list', :partial => 'list'
                       end
                  }
    end

   # @contact_lists = ContactList.all

    #respond_to do |format|
      #format.html # index.html.erb
      #format.xml  { render :xml => @admin_contact_lists }
    #end
  end

  # GET /admin_contact_lists/1
  # GET /admin_contact_lists/1.xml
  def show
    @contact_list = ContactList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_list }
    end
  end

  # GET /admin_contact_lists/new
  # GET /admin_contact_lists/new.xml
  def new
    @contact_list = ContactList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact_list }
    end
  end

  # GET /admin_contact_lists/1/edit
  def edit
    @contact_list = ContactList.find(params[:id])
  end

  # POST /admin_contact_lists
  # POST /admin_contact_lists.xml
  def create
    @contact_list = ContactList.new(params[:contact_list])
   
    respond_to do |format|
      if @contact_list.save
        flash[:notice] = 'contact list was successfully created.'
        format.html { redirect_to(admin_contact_lists_path) }
        format.xml  { render :xml => @contact_list, :status => :created, :location => @contact_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_contact_lists/1
  # PUT /admin_contact_lists/1.xml
  def update
    @contact_list = ContactList.find(params[:id])

    respond_to do |format|
      if @contact_list.update_attributes(params[:contact_list])
        flash[:notice] = 'contact list was successfully updated.'
        format.html { redirect_to(admin_contact_lists_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_contact_lists/1
  # DELETE /admin_contact_lists/1.xml
  def destroy
    @contact_list = ContactList.find(params[:id])
    @contact_list.destroy

    respond_to do |format|
      format.html { redirect_to(admin_contact_lists_url) }
      format.xml  { head :ok }
    end
  end
end
