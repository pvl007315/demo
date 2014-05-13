public with sharing class Shop {
	public String category{get;set;}
	public Boolean isResultNotEmpty{get;set;}
	public Boolean isAdd{get;set;}
	public List<Shop__c> addShop{get;set;}
	public List<Shop__c> selectedItem{get;set;}
	public Integer itemCount{get;set;}

	List<ShopWrapper> newList = new List<ShopWrapper>();

	class ShopWrapper{
		public Shop__c Shop { get; set; }
		public Boolean isSelected{ get; set; }
		ShopWrapper(Shop__c c) {
			Shop = c;

		}
	}


	public Shop()   {
		addShop = new  List<Shop__c>();
		itemCount = 0;
		selectedItem = new List<Shop__c>();
		category = 'phone';
		isResultNotEmpty = true;
		isAdd = false;
	}

	public void getSelected() {
		selectedItem.clear();
		for (ShopWrapper wrapper: newList) {
			if (wrapper.isSelected == true) {
				selecteditem.add(wrapper.Shop);
			}
		}
	}

	public void isResult() {
		List<Shop__c> testResult = [SELECT category__c FROM Shop__c WHERE category__c =: category];
		if (testResult.size() > 0) {
			isResultNotEmpty = true;
		}
		else {
			isResultNotEmpty = false;
			isAdd = false;
		}
	}

	public List<ShopWrapper> Result {
		get{
			newList.clear();
			List<Shop__c> items = [SELECT Name, info__c FROM Shop__c WHERE category__c = :category];
			for (Shop__c sh: items) {
				newList.add(new ShopWrapper(sh));
			}
			return newList;
		}

		set{}
	}

	public static List<SelectOption> getPicklistValues() {
		String fld = 'category__c';
		List<SelectOption> options = new List<SelectOption>();
		Schema.sObjectType objType = Shop__c.getSObjectType();
		Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
		Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
		List<Schema.PicklistEntry> values = fieldMap.get(fld).getDescribe().getPickListValues();
		for (Schema.PicklistEntry a : values) {
			options.add(new SelectOption(a.getLabel(), a.getValue()));
		}
		return options;
	}

	public PageReference Add() {
		try {
			isAdd = true;
			Boolean isItem ;
			for (Shop__c c: selecteditem) {
				isItem = false;
				if (addShop.isEmpty()) {
					addShop.add(c);
					itemCount++;
				}
				else {
					for (Shop__c original: addShop) {
						if (original.Name == c.Name) {
							isItem = true;
						}
					}
					if (!isItem) {
						addShop.add(c);
						itemCount++;
					}
				}
			}

			System.debug(addShop);

		} catch (Exception e) {
			apexPages.addMessages(e);
		}
		return NULL;
	}

	public PageReference Transfer() {
		pageReference newPage = page.ShopBasket;
		newPage.getParameters().put('basketItems', JSON.serialize(addShop));
		return newPage;
	}
}