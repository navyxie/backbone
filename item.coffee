window.YS ?= {}
$ = window.jQuery
YS.BaseItem = Backbone.Model.extend {
	initialize : ->
}

YS.ItemListView = Backbone.View.extend {
	remove : (i) ->
		@model.remove @model.at i
		@render()
		@
	update : ->
		@
	getTableHtml : ->
		self = @
		getThead = (fields) ->
			thead = '<thead><tr>'
			_.each fields, (field) ->
				thead += "<th class='#{field.className}'>#{field.name}</th>"
			thead += '</tr></thead>'
		getTbody = (items) ->
			getTr = (item) ->
				self.template item
			tbody = '<tbody>'
			_.each items, (item, i) ->
				if i % 2
					item.className = 'odd'
				else
					item.className = 'even'
				tbody += getTr item
			tbody += '</tbody>'
		thead = getThead @options.fields
		tbody = getTbody @model.toJSON()
		"<table>#{thead}#{tbody}</table>"
	async : (data, i) ->
		@model.at(i).set data
		@update()
		@
}