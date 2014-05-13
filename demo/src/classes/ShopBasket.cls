public with sharing class ShopBasket {
	public List<Shop__c> basketList{get;set;}
	public String getBasketList{get;set;}

	public ShopBasket() {
		getBasketList = ApexPages.currentPage().getParameters().get('basketItems');

	}


}