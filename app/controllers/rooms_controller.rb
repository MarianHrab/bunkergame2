class RoomsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @rooms = Room.all
      end
    
      def new
        @room = Room.new
      end
    
      def create
        @room = Room.find(params[:room_id])
      
        # Check if the user already has a player in the room
        if @room.players.exists?(user_id: current_user.id)
          redirect_to @room, alert: 'You already have a player in this room.'
        else
          @player = @room.players.build(player_params)
      
          if @player.save
            redirect_to @room, notice: 'Player was successfully created.'
          else
            render :new
          end
        end
      end
      
    
      def show
        @room = Room.find(params[:id])
        @players = @room.players
        @player = Player.new
      end
    
      def take_slot
        @room = Room.find(params[:id])
        @player = @room.players.build(player_params)
    
        if @player.save
          redirect_to room_path(@room), notice: 'Slot taken successfully.'
        else
          render :show
        end
      end
    
      private
      def room_params
        params.require(:room).permit(:name, :capacity)
      end
      
    
      def player_params
        params.require(:player).permit(:name)
      end
    
end
