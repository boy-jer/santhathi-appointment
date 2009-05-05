class DischargeSummariesController < ApplicationController
  layout 'cms'

  def index
    @discharge_summaries = DischargeSummary.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @discharge_summaries }
    end
  end

  def show
    @discharge_summary = @appointment.discharge_summary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @discharge_summary }
    end
  end

  def new
  	ds = DischargeSummary.find_by_appointment_id(params[:appointment_id])
  	redirect_to edit_appointment_discharge_summary_path(:appointment_id => ds.appointment_id,:id=> ds.id) unless ds.blank?
  	@appointment = Appointment.find(params[:appointment_id])
    @discharge_summary = DischargeSummary.new


  end

  def edit
    @discharge_summary = DischargeSummary.find(params[:id])
  end

  def create
  	@appointment = Appointment.find(params[:appointment_id])
   # @discharge_summary = @appointment.discharge_summary.create(params[:discharge_summary])

    @discharge_summary  = DischargeSummary.new(params[:discharge_summary])
    @discharge_summary.appointment = @appointment


    respond_to do |format|
      if @discharge_summary.save
        flash[:notice] = 'DischargeSummary was successfully created.'
        format.html { redirect_to(new_appointment_clinical_screen_path(@appointment)) }
        format.xml  { render :xml => @discharge_summary, :status => :created, :location => @discharge_summary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @discharge_summary.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
  	@appointment = Appointment.find(params[:appointment_id])
    @discharge_summary = DischargeSummary.find(params[:id])

    respond_to do |format|
    	puts 'qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq'
      if @discharge_summary.update_attributes(params[:discharge_summary])
      	puts 'ppppppppppppppppppppppppppppppppppp'
        flash[:notice] = 'DischargeSummary was successfully updated.'
        format.html { redirect_to(new_appointment_clinical_screen_path(@appointment)) }
        format.xml  { head :ok }
      end
    end
  end


  def destroy
    @discharge_summary = DischargeSummary.find(params[:id])
    @discharge_summary.destroy

    respond_to do |format|
      format.html { redirect_to(discharge_summaries_url) }
      format.xml  { head :ok }
    end
  end



end
