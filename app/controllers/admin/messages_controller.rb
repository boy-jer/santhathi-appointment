class Admin::MessagesController < ApplicationController
  require_role :admin
  layout 'admin'

  # GET /admin_messages
  # GET /admin_messages.xml
  def index
    @messages = Admin::Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_messages }
    end
  end

  # GET /admin_messages/1
  # GET /admin_messages/1.xml
  def show
    @message = Admin::Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /admin_messages/new
  # GET /admin_messages/new.xml
  def new
    @message = Admin::Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /admin_messages/1/edit
  def edit
    @message = Admin::Message.find(params[:id])
  end

  # POST /admin_messages
  # POST /admin_messages.xml
  def create
    @message = Admin::Message.new(params[:admin_message])

    begin
      respond_to do |format|
        if @message.save
          sms = MessageService.create(:sms => params[:admin_message])
          @message.update_attributes({:status => "Sent", :sms_id => sms.id})
 
          flash[:notice] = 'SMS is successfully sent.'
          format.html { redirect_to(new_admin_message_url) }
          format.xml  { render :xml => @message, :status => :created, :location => @message }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
        end
      end
    rescue
       flash[:error] = 'Some thing went wrong. Message is not sent.Please try again latter.'  
       render :action => "new"
    end
  end

  # PUT /admin_messages/1
  # PUT /admin_messages/1.xml
  def update
    @message = Admin::Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Admin::Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_messages/1
  # DELETE /admin_messages/1.xml
  def destroy
    @message = Admin::Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(admin_messages_url) }
      format.xml  { head :ok }
    end
  end
end
