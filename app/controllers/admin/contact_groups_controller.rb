class Admin::ContactGroupsController < ApplicationController
  # GET /admin_contact_groups
  # GET /admin_contact_groups.xml
  layout 'admin_single_column'
  def index
    @contact_groups = ContactGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_contact_groups }
    end
  end

  # GET /admin_contact_groups/1
  # GET /admin_contact_groups/1.xml
  def show
    @contact_group = ContactGroup.find(params[:id])
    @contact_lists = ContactList.find(:all, :conditions => ['contact_group_id = ?', @contact_group.id]) 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_group }
    end
  end

  # GET /admin_contact_groups/new
  # GET /admin_contact_groups/new.xml
  def new
    @contact_group = ContactGroup.new
    @contact_lists = ContactList.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact_group }
    end
  end

  # GET /admin_contact_groups/1/edit
  def edit
    @contact_group = ContactGroup.find(params[:id])
    @contact_lists = ContactList.find(:all, :conditions => ['contact_group_id = ?', @contact_group.id]) 
    @non_group_contacts = ContactList.find(:all, :conditions => ['contact_group_id != ?', @contact_group.id]) 
  end

  # POST /admin_contact_groups
  # POST /admin_contact_groups.xml
  def create
    @contact_group = ContactGroup.new(params[:contact_group])
    contacts = params[:contacts]
    respond_to do |format|
      if @contact_group.save
      	unless contacts.blank?
          contacts.each do  |contact|
          @contact_group.contact_lists << ContactList.find(contact)
         end
      end
       flash[:notice] = "#{@contact_group.name} was successfully created."
       format.html { redirect_to(admin_contact_groups_url) }
       format.xml  { render :xml => @contact_group, :status => :created, :location => @contact_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_group.errors, :status => :unprocessable_entity }
      end
    end
   
  end

  # PUT /admin_contact_groups/1
  # PUT /admin_contact_groups/1.xml
  def update
    
    
    @contact_group = ContactGroup.find(params[:id])
    contacts = params[:contacts]
    @contact_group.contact_lists.clear
    respond_to do |format|
      if @contact_group.update_attributes(params[:group])
      	unless contacts.nil?
        	contacts.each do  |contact|
        		 @contact_group.contact_lists << ContactList.find(contact)
        	end
        end
        flash[:notice] = "#{@contact_group.name} was successfully updated."
         format.html { redirect_to(admin_contact_groups_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_group.errors, :status => :unprocessable_entity }
      end
    end



  end

  # DELETE /admin_contact_groups/1
  # DELETE /admin_contact_groups/1.xml
  def destroy
    @contact_group = ContactGroup.find(params[:id])
    @contact_group.destroy

    respond_to do |format|
      format.html { redirect_to(admin_contact_groups_url) }
      format.xml  { head :ok }
    end
  end
end
