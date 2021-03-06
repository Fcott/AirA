class PagesController < ApplicationController
  def home
    @rooms = Room.limit(3)
  end

  def search

    # for location
    if params[:search].present?
      session[:loc_search] = params[:search]
    end

    arrResult = Array.new

    if session[:loc_search].present?
      @rooms_address = Room.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @rooms_address = Room.where(active: true).all
    end

    @search = @rooms_address.ransack(params[:q])
    @rooms = @search.result

    @arrRooms = @rooms.to_a

    if params[:start_date].present? && params[:end_date].present?

      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @rooms.each do |room|

        not_available.length = room.reservations.where(
        "(? <= start_date AND start_date <= ?)
        OR ( ? <= end_date AND end_date <= ?)
        OR ( start_date < ? AND ? < end_date)",
        start_date, end_date,
        start_date, end_date,
        start_date, end_date
        ).limit(1)

        if not_available > 0
          @arrRooms.delete(room)
        end
      end
    end
  end
end
