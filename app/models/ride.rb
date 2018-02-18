class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    user = self.user
    attraction = self.attraction

    if meet_requirements?
      user.update(
        tickets: user.tickets - attraction.tickets,
        nausea: user.nausea + attraction.nausea_rating,
        happiness: user.happiness + attraction.happiness_rating
      )
      "Thanks for riding the #{attraction.name}!"
    elsif !enough_tickets? && !tall_enough?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    elsif !enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif !tall_enough?
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    end
  end

  def enough_tickets?
    user.tickets >= attraction.tickets
  end

  def tall_enough?
    user.height >= attraction.min_height
  end

  def meet_requirements?
    enough_tickets? && tall_enough?
  end
end
