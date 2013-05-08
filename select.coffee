window.YS ?= {}
$ = window.jQuery

YS.SelectItem = YS.BaseItem.extend {
}
YS.SelectItemList = Backbone.Collection.extend {
	model : YS.SelectItem
}

YS.SelectItemListView = YS.ItemListView.extend {
	template : _.template '<tr class="item">' +
		'<td><a href="javascript:;" class="check"></a></td>' +
		'<td><%= name %></td>' +
		'<td><%= barcode %></td>' +
		'<td><%= size %></td>' +
	'</tr>'
	events : 
		'click .select' : 'select'
		'click .close' : 'close'
		'dblclick .item' : 'itemDblClick'
		'click .item' : 'itemClick'
	initialize : ->
		@$el.addClass 'selectItemTable itemTable'
		@render()
	itemDblClick : (e) ->
		obj = $ e.currentTarget
		@getData [obj.index()]
	itemClick : (e) ->
		obj = $ e.currentTarget
		obj.find('.check').toggleClass 'selected'
	select : (e)->
		$el = @$el
		indexArr = []
		$el.find('.item .check.selected').each () ->
			obj = $ @
			indexArr.push obj.closest('.item').index()
		@getData indexArr
	getData : (indexArr) ->
		model = @model
		selectedData = []
		_.each indexArr, (index) ->
			item = model.at index
			if item
				selectedData.push item.toJSON()
		@options.select selectedData
		@close()
	open : (key) ->
		@$el.show()
	close : ->
		@$el.hide().find('.item .check.selected').removeClass 'selected'
	render : ->
		self = @
		tableHtml = @getTableHtml()
		ctrlsStr = '<div class="ctrlBtns"><a class="select btn" href="javascript:;">确定</a><a class="close btn" href="javascript:;">关闭</a></div>'
		@$el.html "#{tableHtml}#{ctrlsStr}"
}