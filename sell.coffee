window.YS ?= {}
$ = window.jQuery

YS.SellItem = YS.BaseItem.extend {
	defaults:
		price : 1
		count : 1
		auxiliaryCount : ''
		priceTotal : ''
	initialize : ->
		@changeCount @, @get 'count'
		@changePrice @, @get 'price'
		@on 'change:count', @changeCount
		@on 'change:price', @changePrice
	changeCount : (model, value) ->
		unitRelation = model.get 'unitRelation'
		oldValue = value
		value = window.parseInt value
		if _.isNaN value
			value = model.previous 'count'
		if oldValue != value
			model.set 'count', value
			return
		price = model.get 'price'
		packTotal = Math.floor value / unitRelation
		unitTotal = value % unitRelation
		auxiliaryCount = ''
		if packTotal
			auxiliaryCount = "#{packTotal}#{model.get('auxiliaryUnit')}"
		if unitTotal
			auxiliaryCount += "#{unitTotal}#{model.get('unit')}"
		model.set 'auxiliaryCount', auxiliaryCount
		if price
			@changePrice model, price
		@
	changePrice : (model, value) ->
		oldValue = value
		value = window.parseFloat value
		if _.isNaN value
			value = model.previous 'price'
		if oldValue != value
			model.set 'price', value
			return 
		count = model.get 'count'
		if count
			model.set 'priceTotal', (count * value).toFixed 2
		@
}

YS.SellItemList = Backbone.Collection.extend {
	model : YS.SellItem
}

YS.SellItemListView = YS.ItemListView.extend {
	template : _.template '<tr class="item <%= className %>">' +
		'<td class="op"><a class="remove" href="javascript:;" title="从表格删除该项"> </a></td>' +
		'<td class="name"><%= name %></td>' +
		'<td class="barcode"><%= barcode %></td>' +
		'<td class="size"><%= size %></td>' +
		'<td class="count"><input type="text" placeholder="商品购买数量" data-key="count" value=<%= count %> class="userInput" /></td>' +
		# '<td><%= unit %></td>' +
		'<td class="auxiliaryCount"><%= auxiliaryCount %></td>' +
		'<td class="price"><input type="text" placeholder="商品购买单价" data-key="price" value=<%= price %> class="userInput" /></td>' +
		'<td class="priceTotal"><%= priceTotal %></td>' +
	'</tr>'
	events : 
		'dblclick .showSelectList' : 'showSelectList'
		'focus input.userInput' : 'userInputFocus'
		'blur input.userInput' : 'userInputBlur'
		'change input.userInput' : 'userInputChange'
		'click .remove' : 'removeClick'
		'keyup .showSelectList' : 'showSelectListKeyup'
	initialize : ->
		@$el.addClass 'sellItemTable itemTable'
		@model.bind 'add', @render, @
		@render()
	userInputFocus : (e) ->
		obj = $ e.currentTarget
		obj.data 'prevValue', obj.val()
		obj.val ''
		@
	userInputBlur : (e) ->
		obj = $ e.currentTarget
		if !obj.val()
			obj.val obj.data 'prevValue'
		@
	userInputChange : (e) ->
		obj = $ e.currentTarget
		trObj = obj.closest 'tr'
		index = trObj.index()
		key = obj.attr 'data-key'
		data = {}
		data[key] = obj.val()
		@async data, index
		@
	removeClick : (e) ->
		obj = $ e.currentTarget
		index = obj.closest('tr').index()
		@remove index
		@
	showSelectListKeyup : (e) ->
		if e.keyCode == 0x0d
			@showSelectList()
		@
	showSelectList : ->
		@options.showSelectList @$el.find('.showSelectList').val()
		@
	add : (data) ->
		if data
			@model.add data
		@
	update : ->
		model = @model
		itemObjs = @$el.find '.item'
		for i in [0...model.length]
			itemObj = itemObjs.eq i
			item = model.at i
			itemObj.find('.price').val item.get 'price'
			itemObj.find('.count').val item.get 'count'
			itemObj.find('.auxiliaryCount').text item.get 'auxiliaryCount'
			itemObj.find('.priceTotal').text item.get 'priceTotal'
		@
	render : ->
		self = @
		getPriceTotal = (priceTotalList) ->
			 _.reduce priceTotalList, (memo, priceTotal) ->
			 	memo + window.parseFloat priceTotal
			 , 0
		items = @model.toJSON()
		tableHtml = @getTableHtml()
		priceTotal = getPriceTotal _.pluck items, 'priceTotal'
		ctrlHtml = '<div class="ctrls"><input class="showSelectList" placeholder="显示商品列表" /></div>'

		priceTotalHtml = "<div class='priceTotal'>总价：<span>#{priceTotal}</span>元</div>"
		othersHtml = "<div class='othersInfo'>#{ctrlHtml}#{priceTotalHtml}</div>"
		@$el.html "#{tableHtml}#{othersHtml}"
		@
}