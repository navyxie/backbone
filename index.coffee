window.YS ?= {}
$ = window.jQuery

$ ->

	sellItemList = new YS.SellItemList()
	sellItemListView = new YS.SellItemListView {
		el : $('#sellItemsContainer')[0]
		model : sellItemList
		showSelectList : (key) ->
			selectItemListView.open key
		fields : [
			{
				name : ' '
				className : 'op'
			}
			{
				name : '商品名'
				className : 'name'
			}
			{
				name : '条码'
				className : 'barcode'
			}
			{
				name : '规格'
				className : 'size'
			}
			{
				name : '数量'
				className : 'count'
			}
			{
				name : '辅助数量'
				className : 'auxiliaryCount'
			}
			{
				name : '单价'
				className : 'price'
			}
			{
				name : '总价'
				className : 'priceTotal'
			}
		]
	}


	selectItemList = new YS.SelectItemList()
	selectItemList.add new YS.SelectItem {
			name : '箭牌绿箭'
			barcode : '69019388'
			size : '1*60*20'
			unit : '盒'
			auxiliaryUnit : '件'
			unitRelation : 60
			abbr : 'JPLJ'
			price : 20
			buyPrice : 20.12
			stocks : [
				{
					id : 1
					count : 1000
				}
			]
			tags : ['箭牌', '口香糖']
			brand : '箭牌'
	}

	selectItemList.add new YS.SelectItem {
			name : '箭牌黄箭'
			barcode : '69019398'
			size : '1*60*20'
			unit : '盒'
			auxiliaryUnit : '件'
			unitRelation : 60
			abbr : 'JPHJ'
			price : 20
			buyPrice : 20.12
			stocks : [
				{
					id : 1
					count : 1000
				}
			]
			tags : ['箭牌', '口香糖']
			brand : '箭牌'
	}
	selectItemListView = new YS.SelectItemListView {
		el : $('#selectContainer')[0]
		model : selectItemList
		select : (data) ->
			sellItemListView.add data
		fields : [
			{
				name : ' '
				className : 'op'
			}
			{
				name : '商品名'
				className : 'name'
			}
			{
				name : '条码'
				className : 'barcode'
			}
			{
				name : '规格'
				className : 'size'
			}
		]
	}

	# _.delay () ->
	# 	sellItemList.add new YS.SellItem {
	# 		name : '箭牌绿箭'
	# 		barcode : '69019388'
	# 		size : '1*60*20'
	# 		unit : '盒'
	# 		auxiliaryUnit : '件'
	# 		unitRelation : 60
	# 		abbr : 'JPLJ'
	# 		buyPrice : 20.12
	# 		stocks : [
	# 			{
	# 				id : 1
	# 				count : 1000
	# 			}
	# 		]
	# 		tags : ['箭牌', '口香糖']
	# 		brand : '箭牌'
	# 	}
	# , 200

# item = new Item {
# 	name : '箭牌绿箭'
# 	barcode : '69019388'
# 	size : '1*60*20'
# 	unit : '盒'
# 	auxiliaryUnit : '件'
# 	unitRelation : 60
# 	abbr : 'JPLJ'
# 	buyPrice : 20.12
# 	stocks : [
# 		{
# 			id : 1
# 			count : 1000
# 		}
# 	]
# 	tags : ['箭牌', '口香糖']
# 	brand : '箭牌'
# }
