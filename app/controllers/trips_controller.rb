class TripsController < ApplicationController
  def index
    params.permit!
    @trips = Trip.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @trip = Trip.find_by_confirmation_token(params[:id])
    unless @trip.confirmed?
      flash[:notice] = "Your ad is saved but not yet published. We have sent you a confirmation email to validate your ad."
    end
  end

  def new
    @trip = Trip.new
    build_points
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to @trip, notice: "Your ad is saved but not yet published. We have sent you a confirmation email to validate your ad."
    else
      build_points
      render :new
    end
  end

  # caution, this is a modifying action reached by a GET method
  def confirm
    @trip = Trip.find_by(confirmation_token: params[:token])
    if @trip
      if @trip.confirm!
        redirect_to @trip, notice: "Your ad is published! Thank you for your contribution to the community!"
      else
        render :not_found # let's give no information on this error to the internet
      end
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  def edit
    flash[:notice] = "You can edit your ad by updating the form below."
    @trip = Trip.find_by(edition_token: params[:token])
    if @trip
      build_points
      render :edit
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  def update
    @trip = Trip.find_by_confirmation_token(params[:id])
    if @trip.update_attributes(trip_params)
      redirect_to @trip, notice: "Your ad is up-to-date Thank you for your contribution to the community!"
    else
      build_points
    end
  end

  # caution, this is a destructive action reached by a GET method
  def delete
    @trip = Trip.find_by(deletion_token: params[:token])
    if @trip
      if @trip.soft_delete!
        render :show, notice: "Your ad is deleted. To cancel click here: <a href='/trips/@trip.id/confirm?confirmation_token:#{@trip.confirmation_token}'> Cancel </a>"
      else
        render :not_found # let's give no information on this error to the internet
      end
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  def points
    @trip = Trip.find_by_confirmation_token(params[:id])
    render json: @trip.points
  end

  def resend_email
    @trip = Trip.find_by_confirmation_token(params[:id])
    if @trip
      @trip.send_information_email
      redirect_to @trip, notice: "We sent you the ad management email to the ad."
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  def new_from_copy
    @trip = Trip.find_by_confirmation_token(params[:id])
    if @trip
      @trip = @trip.clone_without_date
      render :new
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  def new_for_back
    @trip = Trip.find_by_confirmation_token(params[:id])
    if @trip
      @trip = @trip.clone_as_back_trip
      render :new
    else
      render :not_found # let's give no information on this error to the internet
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:departure_date,
      :departure_time,
      :price,
      :description,
      :title,
      :name,
      :age,
      :phone,
      :email,
      :seats,
      :comfort,
      :smoking,
      :terms_of_service,
      points_attributes: %i[
        id kind rank city lon lat _destroy
      ])
  end

  def build_points
    return nil if @trip.nil?

    point_from = @trip.point_from || @trip.points.build(kind: "From")
    point_to = @trip.point_to || @trip.points.build(kind: "To")
    @required_points = [point_from, point_to]
    @optional_points = @trip.step_points.empty? ? build_three_step_points : @trip.step_points
  end

  def build_three_step_points
    return nil if @trip.nil?

    three_step_points = []
    3.times do |i|
      three_step_points << @trip.points.build(kind: "Step", rank: (i + 1))
    end
    three_step_points
  end
end
