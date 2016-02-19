###*
 * This class controls the Clients component and makes
 * the client logos appear in sequence.
###
class Clients

	constructor: ->

		@logos = Array.prototype.slice.call document.querySelectorAll ".js-client-logo"

		# The state variable
		@shown = false

		# How long between each logo is displayed
		@config =
			delay: 100

	###*
	 * Show the client logos. This function is called
	 * by another class, e.g.
	 * Clients = require("clients");
	 * Clients.showLogos();
	###
	showLogos: ->

		# Only run this code if the logos aren't
		# already shown
		if @logos.length and !@shown

			logoCount = @logos.length

			tmp = @logos.slice 0

			# loop through each logo at
			# the specified interval and
			# display them
			@interval = setInterval =>
				tmp.shift().classList.add "is-shown"
				logoCount--
				if logoCount is 0
					clearInterval @interval
			, @config.delay

			@shown = true


module.exports = new Clients