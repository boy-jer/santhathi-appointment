class Admin::SavedMessagesController < ApplicationController
  # GET /admin_saved_messages
  # GET /admin_saved_messages.xml
layout 'admin_single_column'
  def index
    @saved_messages = Admin::SavedMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_saved_messages }
    end
  end

  # GET /admin_saved_messages/1
  # GET /admin_saved_messages/1.xml
  def show
    @saved_message = Admin::SavedMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @saved_message }
    end
  end

  # GET /admin_saved_messages/new
  # GET /admin_saved_messages/new.xml
  def new
    @saved_message = Admin::SavedMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @saved_message }
    end
  end

  # GET /admin_saved_messages/1/edit
  def edit
    @saved_message = Admin::SavedMessage.find(params[:id])
  end

  # POST /admin_saved_messages
  # POST /admin_saved_messages.xml
  def create
    @saved_message = Admin::SavedMessage.new(params[:admin_saved_message])

    respond_to do |format|
      if @saved_message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(admin_saved_messages_path) }
        format.xml  { render :xml => @saved_message, :status => :created, :location => @saved_message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @saved_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_saved_messages/1
  # PUT /admin_saved_messages/1.xml
  def update
    @saved_message = Admin::SavedMessage.find(params[:id])

    respond_to do |format|
      if @saved_message.update_attributes(params[:admin_saved_message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(admin_saved_messages_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @saved_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_saved_messages/1
  # DELETE /admin_saved_messages/1.xml
  def destroy
    @saved_message = Admin::SavedMessage.find(params[:id])
    @saved_message.destroy

    respond_to do |format|
      format.html { redirect_to(admin_saved_messages_url) }
      format.xml  { head :ok }
    end
   end

  
end
