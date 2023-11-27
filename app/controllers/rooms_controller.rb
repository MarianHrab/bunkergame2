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

      def check_owner
        unless @room.owner == current_user
          redirect_to @room, alert: 'You are not the owner of this room.'
        end
      end
    
      def show
        @room = Room.find(params[:id])
        @players = @room.players.includes(:characteristic)
        @player = Player.new
      end

      def destroy
        @room = Room.find(params[:id])
        @room.players.destroy_all
        @room.destroy
        redirect_to rooms_path, notice: 'Room was successfully destroyed.'
      end
    
    
      def take_slot
        @room = Room.find(params[:id])

        # Перевірте, чи гра не розпочалася і чи ще можна зайняти місце
        if !@room.game_started && @room.players.count < @room.limit
          # Перевірте, чи у користувача вже є гравець у кімнаті
          if @room.players.exists?(user_id: current_user.id)
            flash[:alert] = "You already have a player in this room."
          else
            # Якщо користувач ще не має гравця у кімнаті, створіть нового гравця
            @player = @room.players.create(user: current_user)
            flash[:notice] = "You've taken a slot in the room."
          end
        else
          flash[:alert] = "The room is already full or the game has started."
        end

        redirect_to @room
      end

      
      
      def start_game
        @room = Room.find(params[:id])
      
        if @room.owner == current_user && !@room.game_started
          @room.update(game_started: true)
      
          # Оновлення гравців з характеристиками
          @room.players.each do |player|
            player.create_characteristic(
              age: rand(18..50),
              height: rand(150..200),
              weight: rand(50..100),
              health: ['Full healthy', 'Good', 'Average', 'Poor'].sample,
              phobia: ['Heights', 'Spiders', 'Public speaking', 'Clowns'].sample,
              hobby: ['Reading', 'Painting', 'Gardening', 'Cooking'].sample,
              character: ['Adventurous', 'Cautious', 'Optimistic', 'Pessimistic'].sample,
              luggage: ['Backpack', 'Suitcase', 'Duffle bag', 'No bagage'].sample,
              additional_info: Faker::Lorem.sentence,
              knowledge: ['Science', 'History', 'Technology', 'Art'].sample
            )
          end
      
          flash[:notice] = 'Гра почалася!'
        end
      
        redirect_to @room
      end
      
      
      def open_characteristics(player)
        # Check if opened_characteristics is nil or if all characteristics are opened
        if player.opened_characteristics.nil? || player.opened_characteristics.count >= all_characteristics.count
          player.update(opened_characteristics: [])
        end
      
        # Open the next two characteristics for the player
        characteristics_to_open = all_characteristics - player.opened_characteristics
        characteristics_to_open.first(2).each do |characteristic|
          player.opened_characteristics << { name: characteristic, value: generate_random_value_for(characteristic) }
          player.visible_characteristics << characteristic
        end
      end
      
      


      private
      def room_params
        params.require(:room).permit(:name, :limit)
      end
      
    
      def player_params
        params.require(:player).permit(:name)
      end

  end