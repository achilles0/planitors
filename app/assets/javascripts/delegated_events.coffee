#
# Clickable items (with data-href)
#

#http://stackoverflow.com/questions/21700364/javascript-adding-click-event-listener-to-class
document.addEventListener "click", (event)->
	#console.log(event.target instanceof HTMLAnchorElement)
	event.target.getAttribute('data-href') && Turbolinks.visit(event.target.getAttribute('data-href')) && event.preventDefault() unless event.target instanceof HTMLAnchorElement