#
# Clickable items (with data-href)
#

#http://stackoverflow.com/questions/21700364/javascript-adding-click-event-listener-to-class
document.addEventListener "click", (event)->
	#console.log(event.target.parentNode)
	href = event.target.getAttribute('data-href') || event.target.parentNode.getAttribute('data-href')
	href && Turbolinks.visit(href) && event.preventDefault() unless event.target instanceof HTMLAnchorElement