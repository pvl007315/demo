public with sharing class ShopBasket {
	public List<Shop__c> basketList{get;set;}
	public String getBasketList{get;set;}
	public List<String> ShopId{get;set;}

	public ShopBasket() {
		basketList = new List<Shop__c>();
		ShopId = new List<String>();
		getBasketList = ApexPages.currentPage().getParameters().get('basketItems');

		if (getBasketList.length() > 5) {
			Jsonparser parser = JSON.createParser(getBasketList);
			while (parser.nextToken() != NULL) {
				if (parser.getCurrentToken() == Jsontoken.FIELD_NAME) {
					if (parser.getText() == 'Id') {
						parser.nextToken();
						ShopId.add(parser.getText());
					}
				}
			}
		}

		if (ShopId.size() > 0) {
			for (String SId: ShopId) {
				basketList.add([SELECT Id, Name, category__c, info__c FROM Shop__c WHERE Id = :SId]);
			}
		}
	}


}