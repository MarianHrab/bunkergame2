class RoomsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @rooms = Room.all
      end
    
      def new
        @room = Room.new
      end
    
      def create
        @room = Room.new(room_params)
        @room.owner = current_user
      
        if @room.save
          flash[:notice] = 'Room was successfully created.'
          redirect_to @room
        else
          render :new
        end
      end


      def show
        @room = Room.find(params[:id])
        @players = @room.players
        @player = Player.new
      end
    
      def take_slot
        @room = Room.find(params[:id])
      
        # Перевірте, чи у користувача вже є гравець у кімнаті
        if @room.players.exists?(user_id: current_user.id)
          # Якщо у користувача вже є гравець у кімнаті, можливо, ви хочете вивести повідомлення або зробити щось інше
          flash[:alert] = "You already have a player in this room."
        else
          # Якщо користувач ще не має гравця у кімнаті, створіть нового гравця
          @player = @room.players.create(user: current_user)
          flash[:notice] = "You've taken a slot in the room."
        end
      
        redirect_to @room
      end
      
    
      private
      def room_params
        params.require(:room).permit(:name) 
      end
      
    
      def player_params
        params.require(:player).permit(:name)
      end
    
end
