Page = require "page"
svgLoader = require "../svg-loader/svg-loader.coffee"

class PageTransition

	constructor: (el) ->

		@el =
			pages: el.querySelectorAll ".o-page-transition__page-container"
			overlay: el.querySelector ".o-page-transition__overlay"
			triggers: el.querySelectorAll ".js-trigger-page-transition"
			wrapper: el

		@currentPage = "home"

		@loader = loader = new SVGLoader @el.overlay,
			easingIn: mina.easeinout
			speedIn: 400

		@pages = @indexPages()

		@addEventListeners()
		@setupRouting()

	addEventListeners: ->

		for trigger in @el.triggers

			trigger.addEventListener "click", (e) =>

				e.preventDefault()

				@transition e.target.dataset.page

	hideOverlay: ->

		@loader.hide()
		@el.wrapper.classList.remove "is-loading"

		setTimeout =>

			@el.overlay.classList.remove "is-shown"

		, 400

	hidePage: (page) ->

		@pages[page].classList.remove "is-shown"

	indexPages: ->

		pages = {}

		for page in @el.pages

			pages[page.dataset.page] = page

		pages

	setupRouting: ->

		Page "/", ->
			console.info "Home page"

		Page "/about/me", ->
			console.info "About page"

		Page "/contract", ->
			console.info "Contract"

	showOverlay: ->

		@el.wrapper.classList.add "is-loading"
		@el.overlay.classList.add "is-shown"
		@loader.show()

	showPage: (page) ->

		@pages[page].classList.add "is-shown"

	transition: (targetPage) ->

		@showOverlay()

		setTimeout =>

			@hidePage @currentPage
			@showPage targetPage

			switch targetPage
				when "home" then Page "/"
				when "about" then Page "/about/me"
				when "contract" then Page "/contract"

			@hideOverlay()
			@currentPage = targetPage

			window.scrollTo 0,0

		, 1000


module.exports = do ->

	pageTransition = document.querySelector ".o-page-transition"

	if pageTransition then new PageTransition pageTransition