# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

health_options = ['Excellent', 'Good', 'Average', 'Poor']
phobia_options = ['Heights', 'Spiders', 'Public speaking', 'Clowns']
hobby_options = ['Reading', 'Painting', 'Gardening', 'Cooking']
character_options = ['Adventurous', 'Cautious', 'Optimistic', 'Pessimistic']
luggage_options = ['Backpack', 'Suitcase', 'Duffle bag', 'No luggage']
knowledge_options = ['Science', 'History', 'Technology', 'Art']

health_options.each do |health|
  phobia_options.each do |phobia|
    hobby_options.each do |hobby|
      character_options.each do |character|
        luggage_options.each do |luggage|
          knowledge_options.each do |knowledge|
            Characteristic.create(
              health: health,
              phobia: phobia,
              hobby: hobby,
              character: character,
              luggage: luggage,
              knowledge: knowledge
            )
          end
        end
      end
    end
  end
end

