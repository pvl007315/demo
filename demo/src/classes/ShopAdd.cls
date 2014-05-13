public with sharing class ShopAdd {
        public Shop__c newShopItem{get;set;}
        public Boolean isInsert{get;set;}

        public ShopAdd() {
                newShopItem = new Shop__c();
                isInsert = false;
        }

        public pageReference SaveItem() {
                try {
                        if (newShopItem.Name != '' && newShopItem.Info__c != '') {
                                insert newShopItem;
                                isInsert = true;
                        }

                } catch (Exception e) {
                        apexPages.addMessages(e);
                }
                return NULL;
        }

}