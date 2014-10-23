User.delete_all
Event.delete_all
EventChoice.delete_all
EventSuggestion.delete_all
EventVenue.delete_all
Invitation.delete_all
Venue.delete_all

User.create(name: "Shehryar Riaz", role: "admin", email: "shehryarriaz@gmail.com", password: "Dinner0rdrink$", password_confirmation: "Dinner0rdrink$")
User.create(name: "Stefanie Lim", role: "admin", email: "stefanie.lim04@gmail.com", password: "Dinner0rdrink$", password_confirmation: "Dinner0rdrink$")